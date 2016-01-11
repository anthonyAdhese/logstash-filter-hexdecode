# encoding: utf-8
require 'spec_helper'
require "logstash/filters/hexdecode"

describe LogStash::Filters::Hexdecode do
  describe "Set to Hello World" do
    let(:config) do <<-CONFIG
      filter {
        hexdecode {
          field => "Hello World"
          target => "url_decoded"
        }
      }
    CONFIG
    end

    sample("field" => "687474703A2F2F73706F727A612E62652F636D2F73706F727A612F6D6174636863656E7465722F6D635F74656E6E69732F6D616E6E656E2F636F6D705F4154505F646F68612F4D475F4154505F646F68615F462F312E32353431313330") do
      expect(subject).to include("url_decoded")
      expect(subject['url_decoded']).to eq('http://sporza.be/cm/sporza/matchcenter/mc_tennis/mannen/comp_ATP_doha/MG_ATP_doha_F/1.2541130')
    end
  end
end
