# encoding: utf-8
require 'spec_helper'
require "logstash/filters/hexdecode"

describe LogStash::Filters::Hexdecode do
  describe "Decode hex string version 1 into different field" do
    let(:config) do <<-CONFIG
      filter {
        hexdecode {
          field => "url"
          target => "url_decoded"
        }
      }
    CONFIG
    end

    sample("url" => "0068007400740070003a002f002f007700770077002e00640068006e00650074002e00620065002f") do
      expect(subject).to include("url_decoded")
      expect(subject['url_decoded']).to eq('http://www.dhnet.be/')
    end
  end
  
  describe "Decode hex string version 1 into same field" do
    let(:config) do <<-CONFIG
      filter {
        hexdecode {
          field => "url"
          target => "url_decoded"
        }
      }
    CONFIG
    end

    sample("url" => "0068007400740070003a002f002f007700770077002e00640068006e00650074002e00620065002f") do
      expect(subject).to include("url")
      expect(subject['url']).to eq('http://www.dhnet.be/')
    end
  end
  
  describe "Decode hex string version 2 into same field" do
    let(:config) do <<-CONFIG
      filter {
        hexdecode {
          field => "url"
        }
      }
    CONFIG
    end

    sample("url" => "687474703A2F2F7777772E64686E65742E62652F") do
      expect(subject).to include("url")
      expect(subject['url']).to eq('http://www.dhnet.be/')
    end
  end
  
  describe "Decode hex string version 2 into different field" do
    let(:config) do <<-CONFIG
      filter {
        hexdecode {
          field => "url"
        }
      }
    CONFIG
    end

    sample("url" => "687474703A2F2F7777772E64686E65742E62652F") do
      expect(subject).to include("url_decoded")
      expect(subject['url_decoded']).to eq('http://www.dhnet.be/')
    end
  end
  
  describe "Decode empty hex stringinto different field" do
    let(:config) do <<-CONFIG
      filter {
        hexdecode {
          field => "url"
		  target => "url_decoded"
        }
      }
    CONFIG
    end

    sample("url" => "") do
      expect(subject).to include("url_decoded")
      expect(subject['url_decoded']).to eq('')
    end
  end
  
  describe "Decode empty hex string into same field" do
    let(:config) do <<-CONFIG
      filter {
        hexdecode {
          field => "url"
        }
      }
    CONFIG
    end

    sample("url" => "") do
      expect(subject).to include("url")
      expect(subject['url']).to eq('')
    end
  end
end
