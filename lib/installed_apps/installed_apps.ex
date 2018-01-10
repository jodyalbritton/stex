defmodule Stex.InstalledApps do
  @moduledoc """
  Manage installed apps
  """


  @doc """
  List all installed apps
  """
  def list(client) do
    response = Stex.get!(client.api_base <> "installedapps", client.headers)
    final =
    response
    |> Stex.parse_res


    final.items
  end


  def show(client, app_id) do
    response = Stex.get!(client.api_base <> "installedapps/#{app_id}", client.headers)
    final =
    response
    |> Stex.parse_res


    final
  end


  def getConfigs(client, app_id) do
    response = Stex.get!(client.api_base <> "installedapps/#{app_id}/configs", client.headers)
    final =
    response
    |> Stex.parse_res


    final.items
  end


end
