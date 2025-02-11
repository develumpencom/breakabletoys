class Kit
  def self.subscribe(user)
    data = {
      email_address: user.email_address,
      first_name: user.username
    }.to_json

    response = connection.post("subscribers", data)
    data = JSON.parse(response.body)

    if response.status == 200 || response.status == 201
      user.update! kit_id: data["subscriber"]["id"], kit_state: data["subscriber"]["state"]
    else
      puts "-" * 100
      p response.status
      pp data
      puts "-" * 100
    end
  end

  private

  def self.connection
    Faraday.new("https://api.kit.com/v4") do |req|
      req.headers["Accept"] = "application/json"
      req.headers["Content-Type"] = "application/json"
      req.headers["X-Kit-Api-Key"] = Rails.application.credentials.dig(:kit, :token)
    end
  end
end
