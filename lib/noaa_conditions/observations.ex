defmodule NoaaConditions.Observations do

  @moduledoc """
  Abstraction of requests to the weather observations web api found at
  http://w1.weather.gov/xml/current_obs/
  """

  def fetch(location_code) do
    location_code
    |> obs_url()
    |> HTTPoison.get
    |> handle_response
  end

  @doc """
  Generate the request url based on the given location code.
  """
  def obs_url(location_code) do
    "http://w1.weather.gov/xml/current_obs/#{location_code}.xml"
  end

  @doc """
  Validate that the response is correct, and parse the response body into
  a valid erlang XML record.
  """
  def handle_response({ :ok, %{ status_code: 200, body: body } }) do
    { :ok, body }
  end
  def handle_response({ _, %{ status_code: code, body: _ } }) do
    { :error, code }
  end
end
