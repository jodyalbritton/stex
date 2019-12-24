defmodule Stex.Locations do
  @moduledoc """
  Manipulate locations using the SmartThings API
  """


  @doc """
   List all authorized locations
  """
  def list(client, params \\ nil) do
    options = [
    ]

     new_opts =
     if params != nil do
      options ++ params
     else
      options
     end

    Stex.get_list("locations", client.headers, [params: new_opts])
    |> Stex.handle_response()
  end

  @doc """
   Show Location
  """
  def show(client, location_id) do
    location =
    Stex.get_single("locations/#{location_id}", client.headers)
    |> Stex.handle_response()

    %{ client: client, location: location}
  end

end
