defmodule Stex.Locations do
  @moduledoc """
  Manipulate locations using the SmartThings API
  """


  @doc """
   List all authorized locations
  """
  def list(client) do
    response = Stex.get!(client.api_base <> "locations", client.headers)
    response
    |> Stex.parse_res
  end

  @doc """
   Show Location
  """
  def show(client, location) do
    response = Stex.get!(client.api_base <> "locations/#{location}", client.headers)
    response
    |> Stex.parse_res
  end

end
