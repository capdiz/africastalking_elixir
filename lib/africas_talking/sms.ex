defmodule AfricastalkingElixir.Sms do
  require Logger

  @moduledoc """
  Send SMS using the AfricasTalking messaging api.
  """
  @moduledoc since: "0.1.0"
  @doc """
  send_sms/3 function expects a list of options, e.g. options = [username: "sandbox", to: "+256700183633", message: "Hello World!"], with the following fields in order to send an SMS:
  1. username (Your africastalking app username. If using africastalking sanbox environment, username is "sandbox").
  2. to (Phone number your sending message to)
  3. message (the actual message)

  When in production you have to provide the env variable to send_sms/3 function
  """

  def send_sms(options \\ [], api_key, env) when is_list(options) and is_binary(api_key) do
    if env == "production" do
      # africastalking live api url (production)
      url = "https://api.africastalking.com/version1/messaging"
      sendMessage(url, options, api_key)
    else
      # africastalking sandbox api url (development)
      url = "https://api.sandbox.africastalking.com/version1/messaging"
      sendMessage(url, options, api_key)
    end
  end

  defp sendMessage(url, options, api_key) do
    body = {:form, options}
    headers = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]
    cond do
      api_key == nil  ->
        Logger.info("AfricasTalking api requires an apiKey")
        {:error, "Please provide your AfricasTalking apiKey"}
      options[:username] == nil ->
        Logger.info("AfricasTalking api require's your app's username")
        {:error, "Please provide your app's username"}
      options[:to] == nil ->
        Logger.info("AfricasTalking api require's a valid phone number")
        {:error, "Please provide a phone number to send message to"}
      true ->
        http_post = HTTPoison.post(url, body, List.insert_at(headers, 0, {:apiKey, api_key}),
                                  [ssl: [{:versions, ['tlsv1.2']}]])
        case http_post do
          {:ok, response} ->
            if response.body == "The supplied authentication is invalid" do
              Logger.info("receiving response from AfricasTalking: #{response.body}")
              response
            else
              Logger.info("receiving response from AfricasTalking: #{response.body}")
              Logger.info Poison.decode!(response.body) |>
                          Enum.map(fn {msg, data} -> Enum.map(data["Recipients"], fn reply -> reply["status"] end) end) |>
                          List.to_string
              response
            end
          {:error, message} ->
            Logger.info "error: #{message.reason} (Please check your internet connection or a connection timeout occured"
          _ ->
            Logger.info "Unknown error occured"
        end
    end
  end
end
