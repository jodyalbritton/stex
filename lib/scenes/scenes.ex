defmodule Stex.Scenes do
  @moduledoc """
  Manage your SmartThings Scenes.
  """

  @doc """
   List all authorized scenes

   Max: 200 by default will return up to 200 scenes.


   ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> Stex.Scenes.list(client)
  """
  def list(client, locationId) do
    options = [
      params: %{
        max: "200"
      }
    ]

    response = Stex.get!("#{client.api_base}scenes?locationId=#{locationId}", client.headers, options)
    final =
    response
    |> Stex.parse_res


    final.items
  end


  @doc """
  Execute a scene
  """
  def execute(client, sceneId) do
    body = Poison.encode!(%{})
    {:ok, response} = Stex.post("#{client.api_base}scenes/#{sceneId}/execute", body, client.headers)

    response
    |> Stex.parse_res
  end

end
