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

  def connect(access_token) do
    %Client{access_token: access_token, api_base: @api_base, headers: build_headers(access_token)}
  end

  def parse_res(response) do
    if response do
        if response.body do
          response.body
          |> Poison.Parser.parse!(keys: :atoms)
        end
      end
  end


  defp build_headers(token) do
    [
      {"Authorization", "Bearer #{token}"},
      {"Content-type", "application/json"},
    ]
  end
end
