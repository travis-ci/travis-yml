describe Travis::Yml::Schema::Def::Imports do
  describe 'imports' do
    subject { Travis::Yml.schema[:definitions][:type][:imports] }

    # it { puts JSON.pretty_generate(subject) }

    it do
      should include(
        '$id': :imports,
        title: 'Imports',
        summary: instance_of(String),
        description: instance_of(String),
        # see: instance_of(Hash),
        anyOf: [
          {
            type: :array,
            items: {
              '$ref': '#/definitions/type/import'
            },
            normal: true
          },
          {
            '$ref': '#/definitions/type/import'
          }
        ]
      )
    end
  end

  describe 'import' do
    subject { Travis::Yml.schema[:definitions][:type][:import] }

    it do
      should include(
        '$id': :import,
        title: 'Import',
        normal: true,
        anyOf: [
          {
            type: :object,
            properties: {
              source: {
                type: :string,
                summary: 'The source to import build config from',
                pattern: Travis::Yml::Schema::Def::Import::SOURCE,
                example: './import.yml@v1'
              },
              mode: {
                type: :string,
                enum: ['merge', 'deep_merge', 'deep_merge_append', 'deep_merge_prepend'],
                summary: instance_of(String)
              },
              if: {
                '$ref': '#/definitions/type/condition'
              }
            },
            additionalProperties: false,
            normal: true,
            prefix: {
              key: :source
            },
          },
          {
            type: :string,
            pattern: Travis::Yml::Schema::Def::Import::SOURCE,
            example: './import.yml@v1'
          }
        ]
      )
    end
  end

  describe 'pattern' do
    def self.matches(str)
      context do
        let(:str) { str }
        it { should be_truthy }
      end
    end

    def self.does_not_match(str)
      context do
        let(:str) { str }
        it { should be_falsey }
      end
    end

    let(:pattern) { Travis::Yml::Schema::Def::Import::SOURCE }

    subject { pattern =~ str }

    describe 'empty string' do
      does_not_match ''
    end

    describe 'remote' do
      describe 'file in root dir' do
        matches 'owner/repo:file.yml@v1'
      end

      describe 'file in sub dir' do
        matches 'owner/repo:path/to/file.yml@v1'
      end

      describe 'file name containing an @' do
        matches 'owner/repo:@file.yml@v1'
      end

      describe 'dir name containing an @' do
        matches 'owner/repo:@path/to/file.yml@v1'
      end

      describe 'no ref given' do
        matches 'owner/repo:file.yml'
      end

      describe 'no file name given' do
        does_not_match 'owner/repo@v1'
      end

      describe 'given a json file name' do
        matches 'owner/repo:.travis.json@v1'
      end

      describe 'given a txt file name' do
        does_not_match 'owner/repo:.travis.txt@v1'
      end
    end

    describe 'local' do
      describe 'file in root dir' do
        matches 'file.yml@v1'
      end

      describe 'file in sub dir' do
        matches 'path/to/file.yml@v1'
      end

      describe 'file name containing an @' do
        matches '@file.yml@v1'
      end

      describe 'dir name containing an @' do
        matches '@path/to/file.yml@v1'
      end

      describe 'no ref given' do
        matches 'file.yml'
      end

      describe 'no file name given' do
        does_not_match '@v1'
      end

      describe 'given a json file name' do
        matches '.travis.json@v1'
      end

      describe 'given a txt file name' do
        does_not_match '.travis.txt@v1'
      end
    end

    describe 'relative' do
      describe 'file in root dir' do
        matches './file.yml@v1'
      end

      describe 'file in sub dir' do
        matches './path/to/file.yml@v1'
      end

      describe 'file name containing an @' do
        matches './@file.yml@v1'
      end

      describe 'dir name containing an @' do
        matches './@path/to/file.yml@v1'
      end

      describe 'no ref given' do
        matches './file.yml'
      end

      describe 'no file name given' do
        does_not_match './@v1'
      end

      describe 'given a json file name' do
        matches './.travis.json@v1'
      end

      describe 'given a txt file name' do
        does_not_match './.travis.txt@v1'
      end
    end
  end
end
