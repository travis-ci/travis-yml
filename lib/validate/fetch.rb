require 'validate/local'
require 'validate/remote'

class Fetch < Struct.new(:from, :count)
  BATCH_SIZE = 50_000

  def run
    fetch = 0
    store = 0
    puts "Checking #{ids.size} requests, ignoring #{repo_ids.size} repos ..."
    requests.find_in_batches(batch_size: BATCH_SIZE) do |requests|
      fetch += requests.size
      requests.group_by(&:repository_id).values.map(&:last).flatten.each do |request|
        store += 1 if store(request)
        print "\r\e[2Kfetched: #{fetch}, stored: #{store}"
      end
    end
    puts
  end

  private

    def requests
      scope = Remote::Request.select(:id, :repository_id, :config)
      scope = scope.where(id: ids)
      scope
    end

    def store(request)
      return if repo_ids.include?(request.repository_id)
      attrs  = { id: request.id, repository_id: request.repository_id, config: request.config }
      record = Local::Request.where(id: request.id).first
      record ? record.update_attributes!(attrs) : Local::Request.create(attrs)
      repo_ids << request.repository_id
    end

    def repo_ids
      @repo_ids ||= Local::Request.distinct.select(&:repository_id).map(&:repository_id)
    end

    def ids
      from...to
    end

    def to
      from.to_i + count.to_i
    end
end

