defmodule Stex do
  @moduledoc """
  Documentation for Stex.
  """

  use HTTPoison.Base

  @api_base "https://api.smartthings.com/v1/"

  defmodule Client do
    @moduledoc """
    Builds a client for accessing the API
    """
      defstruct access_token: nil, api_base: nil, headers: nil
  end


  @doc """
  Connect function creates a map that can be used for chaining commands to the SmartThings API

  Takes a single argument. A personal access token which can be obtained here:

  https://account.smartthings.com/tokens

  returns a map

  %Client{access_token: xyx-qwe-wewewe, api_base: "https://api.smartthings.com/v1/", headers: [
    {"Authorization", "Bearer xyx-qwe-wewewe"},
    {"Content-type", "application/json"},
  ]}
  """
  def connect(access_token) do
    %Client{access_token: access_token, api_base: @api_base, headers: build_headers(access_token)}
  end


  def get_list(endpoint, headers, options) do
    HTTPoison.request(:get, request_url(endpoint), [], headers, options)
  end

  def get_single(endpoint, headers) do
    HTTPoison.request(:get, request_url(endpoint), [], headers)
  end

  def delete_single(endpoint, headers) do
    HTTPoison.request(:delete, request_url(endpoint), [], headers)
  end

  defp request_url(endpoint) do
    @api_base <> endpoint
  end

  def handle_response({:error, struct}), do: {:error, "There was an error", struct}
  def handle_response({:ok, %{body: body, status_code: 200}}), do: parse_res(body)
  def handle_response({:ok, %{body: body, headers: headers, status_code: code}}) do
    %{"error" => error, "message" => message} = Poison.decode!(body)
  end

  @doc """
  Parse the result
  """
  def parse_res(response) do
        response
        |> Poison.Parser.parse!(keys: :atoms)
  end

  defp build_headers(token) do
    [
      {"Authorization", "Bearer #{token}"},
      {"Content-type", "application/json"},
    ]
  end
end
