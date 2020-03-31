require "spec_helper"

describe CarthageCacheRes::ArchiveBuilder do

  let(:cache_dir_name) { "carthage_cache_res" }
  let(:terminal) { MockTerminal.new(false) }
  let(:project) { CarthageCacheRes::Project.new(FIXTURE_PATH, cache_dir_name, nil, terminal, TMP_PATH, MockSwiftVersionResolver.new) }
  let(:archiver) { CarthageCacheRes::Archiver.new(MockCommandExecutor.new) }
  let(:repository) { double("repository") }
  subject(:archive_builder) { CarthageCacheRes::ArchiveBuilder.new(terminal, repository, archiver, project) }

  describe "#build" do

    let(:archive_path) { File.join(project.tmpdir, project.archive_path) }

    it "builds and uploads the archive" do
      expect(repository).to receive(:upload).with(project.archive_path, archive_path)
      archive_builder.build
    end

  end

end
