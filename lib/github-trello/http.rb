require "cgi"
require "net/https"

module GithubTrello
  class HTTP
    def initialize(token, api_key)
      @token, @api_key = token, api_key
      @uri = URI("https://api.trello.com")
    end

    def get_card(board_id, card_id)
      http_request(:get, "/1/boards/#{board_id}/cards/#{card_id}", :params => {:fields => "idList,closed"})
    end

    def add_card(params)
      http_request(:post, "/1/cards}", :params => params)
    end

    def update_card(card_id, params)
      http_request(:put, "/1/cards/#{card_id}", :params => params)
    end

    def add_comment(card_id, comment)
      http_request(:post, "/1/cards/#{card_id}/actions/comments", :body => "text=#{CGI::escape(comment)}")
    end

    def get_cards(list_id)
      http_request(:get, "/1/lists/#{list_id}/cards", :params => {:fields => "idList"})
    end

    private
    def http_request(method, request_path, args={})
      request_path << "?"
      args[:params] ||= {}
      args[:params][:key] = @api_key
      args[:params][:token] = @token
      args[:params].each {|k, v| request_path << "#{k}=#{CGI::escape(v.to_s)}&"}

      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http.start

      if method == :get
        response = http.request_get(request_path)
      elsif method == :post
        response = http.request_post(request_path, args.delete(:body))
      elsif method == :put
        response = http.request_put(request_path, args.delete(:body))
      end

      unless response.code == "200" or response.code == "201"
        raise Net::HTTPError.new("#{response.body == "" ? response.message : response.body.strip} (#{response.code})", response)
      end

      response.body
    end
  end
end
