require "spec_helper"

describe CarthageCacheRes::ConfigurationValidator do

  context "using key and secret" do
    let(:config) do
      config = CarthageCacheRes::Configuration.new
      config.bucket_name = "carthage-cache"
      config.aws_region = "us-west-2"
      config.aws_access_key_id = "AAAAAAAAAAAAAAAAA"
      config.aws_secret_access_key = "BBBBBBBBBBBBBBBBBBBBBBBBBB"
      config.aws_session_token = "CCCCCCCCCCCCCCCCCCCCCCCC"
      config
    end
    subject(:validator) { CarthageCacheRes::ConfigurationValidator.new(config) }

    describe "#valid?" do

      context "when required configuration keys are missing" do


        context "when the bucket name is missing" do

          before(:each) { config.bucket_name = nil }

          it "returns false" do
            expect(validator.valid?).to be_falsy
          end

        end

        context "when there are no credentials" do

          before(:each) { config.aws_region = nil }

          it "returns false" do
            expect(validator.valid?).to be_falsy
          end

        end

        context "when the AWS access key ID is missing and secret is not" do

          before(:each) { config.aws_access_key_id = nil }

          it "returns false" do
            expect(validator.valid?).to be_falsy
          end

        end

        context "when the AWS secret access key is missing and key is not" do

          before(:each) { config.aws_secret_access_key = nil }

          it "returns false" do
            expect(validator.valid?).to be_falsy
          end

        end
        
        context "when the AWS session token is missing and the access key and secret are not" do
          
          before(:each) { config.aws_session_token = nil }
          
          it "returns true" do
            expect(validator.valid?).to be_truthy
          end
          
        end

      end

      context "when the configuration object is valid" do

        it "returns true" do
          expect(validator.valid?).to be_truthy
        end

      end

    end

  end

  context "using profile" do
    let(:config) do
      config = CarthageCacheRes::Configuration.new
      config.bucket_name = "carthage-cache"
      config.aws_region = "us-west-2"
      config.aws_profile = "my-profile"
      config
    end
    subject(:validator) { CarthageCacheRes::ConfigurationValidator.new(config) }

    describe "#valid?" do

      context "when required configuration keys are missing" do


        context "when the bucket name is missing" do

          before(:each) { config.bucket_name = nil }

          it "returns false" do
            expect(validator.valid?).to be_falsy
          end

        end

        context "when the AWS region is missing" do

          before(:each) { config.aws_region = nil }

          it "returns false" do
            expect(validator.valid?).to be_falsy
          end

        end

      end

      context "when the configuration object is valid" do

        it "returns true" do
          expect(validator.valid?).to be_truthy
        end

      end

    end
    
  end

  describe "#read_only?" do
    let(:config) do
      config = CarthageCacheRes::Configuration.new
      config.bucket_name = "carthage-cache"
      config.aws_region = "us-west-2"
      config
    end
    subject(:validator) { CarthageCacheRes::ConfigurationValidator.new(config) }

    context "when there are no credentials" do
      it "returns true" do
        expect(validator.read_only?).to be_truthy
      end
    end

    context "when credentials are found" do

      context "when the AWS profile is found" do

        before(:each) { config.aws_profile = "carthage_cache_res" }

        it "returns false" do
          expect(validator.read_only?).to be_falsy
        end

      end

      context "when the AWS key and secret are found" do

        before(:each) do 
          config.aws_access_key_id = "ID"
          config.aws_secret_access_key = "SECRET"
        end

        it "returns false" do
          expect(validator.read_only?).to be_falsy
        end

      end

      context "when the AWS key only is found" do

        before(:each) { config.aws_access_key_id = "ID" }

        it "returns true" do
          expect(validator.read_only?).to be_truthy
        end

      end

      context "when the AWS only secret is found" do

        before(:each) {  config.aws_secret_access_key = "SECRET" }

        it "returns true" do
          expect(validator.read_only?).to be_truthy
        end

      end

    end

    context "when the configuration object is valid" do

      it "returns true" do
        expect(validator.valid?).to be_truthy
      end

    end

  end

end
