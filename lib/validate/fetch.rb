# frozen_string_literal: true
require 'validate/local'
require 'validate/remote'

class Fetch < Struct.new(:from, :count)
  BATCH_SIZE = 50_000

  def run
    # fetch_repos
    fetch_requests
    purge_duplicate_requests
  end

  private

    def fetch_repos
      count = 0
      started = Time.now
      total = repos.count
      puts "#{total} repositories to import"
      repos.select(:id, :owner_name, :name).find_each(batch_size: BATCH_SIZE) do |repo|
        count = with_eta(started, total, count) do
          next if Record::Repo.where(id: repo.id).first
          Record::Repo.create!(id: repo.id, owner_name: repo.owner_name, name: repo.name)
        end
      end
      puts
    end

    def fetch_requests
      count = 0
      started = Time.now
      # total = Remote::Request.last.id
      total = self.count
      puts "Checking #{self.count} requests starting at #{from} ..."
      requests.select(:id, :repository_id, :config).find_in_batches(batch_size: BATCH_SIZE) do |requests|
        requests.group_by(&:repository_id).values.map(&:last).flatten.each.with_index do |request, ix|
          with_eta(started, total, count + ix) do
            store(request)
          end
        end
        count = count + requests.size
      end
      puts
    end

    def repos
      Remote::Repository.where('last_build_id IS NOT NULL')
    end

    def requests
      scope = Remote::Request
      # scope = scope.where('id > ?', max_request_id)
      # scope = scope.where(id: max_request_id...(max_request_id + count))
      scope = scope.where(id: ids)
      scope
    end

    def request_ids
      @request_ids ||= Record::Request.select(&:id).map(&:id)
    end

    def repo_ids
      @repo_ids ||= Record::Repo.select(&:id).map(&:id)
    end

    def store(request)
      return if request_ids.include?(request.id)
      attrs  = { id: request.id, repo_id: request.repository_id, config: request.config }
      Record::Request.create(attrs)
      request_ids << request.id
    end

    def purge_duplicate_requests
      puts "Purging duplicate requests from #{Record::Request.count} requests ..."
      Record::Request.where('id not in (select max(id) from requests group by repo_id)').delete_all
      puts "Done. #{Record::Request.count} requests left."
    end

    def max_request_id
      @max_request_id ||= Record::Request.maximum(:id).to_i
    end

    def ids
      from...to
    end

    def to
      from.to_i + count.to_i
    end

    def with_eta(started, total, count)
      yield
      count   = count + 1
      pending = total - count
      update  = (Time.now - started) / count
      left    = update * (total - count)
      eta     = (Time.now + left).strftime('%a %m-%d %H:%M')
      sec     = update.round(4).to_s.ljust(6, '0')
      left    = Time.at(left).utc.strftime('%H:%M')
      elapsed = Time.at(Time.now - started).utc.strftime('%H:%M:%S')
      started = started.strftime('%H:%M')
      print "\r\e[2K#{count} done, #{pending} to go. #{sec}s each. Elapsed #{elapsed}, started #{started}, ETA #{eta}, left: #{left}." # if count % 5 == 0
      count
    end

    # def fetch_requests
    #   count = 0
    #   started = Time.now
    #   total = Remote::Request.last.id
    #   Remote::Request.select(:id, :repository_id, :config).find_each(batch_size: BATCH_SIZE) do |request|
    #     count = with_eta(started, total, count) do
    #       store(request)
    #     end
    #   end
    #   puts
    # end

    # def fetch_requests
    #   count = 0
    #   started = Time.now
    #   total = repo_ids.size
    #   repo_ids.each do |id|
    #     count = with_eta(started, total, count) do
    #       request = Remote::Request.select(:id, :repository_id, :config).where(repository_id: id).last
    #       next if request.nil? || Record::Request.where(id: request.id).first
    #       attrs  = { id: request.id, repo_id: request.repository_id, config: request.config }
    #       Record::Request.create!(attrs)
    #     end
    #   end
    # end
end

