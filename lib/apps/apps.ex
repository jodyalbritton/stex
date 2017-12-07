defmodule Stex.Apps do
  @moduledoc """
  Manipulate APPS using the SmartThings API
  """

  @doc """
  List all apps
  """
  def list(client) do
    options = [
      params: %{
        max: "200"
      }
    ]


    response = Stex.get!(client.api_base <> "apps", client.headers, options)
    final =
    response
    |> Stex.parse_res


    final.items
  end

  @doc """
   Show app

  ## Examples
      iex> Stex.Apps.show(client, app_id)
  """
  def show(client, app_id) do
    response = Stex.get!(client.api_base <> "apps/#{app_id}", client.headers)

    app =
    response
    |> Stex.parse_res

    %{client: client, app: app}
  end


  @doc """
   Delete an App
  """
  def delete(client, app_id) do
    response = Stex.delete!(client.api_base <> "apps/#{app_id}", client.headers)
    response.body
  end


  @doc """
  Create an APP
  """

  def createWebhookSmartApp(client, appName, displayName, description, targetUrl) do
    body = Poison.encode!(%{
        "appName" => appName,
        "displayName"=> displayName,
        "description"=> description,
        "singleInstance"=> false,
        "appType" => "WEBHOOK_SMART_APP",
        "webhookSmartApp"=> %{
          "targetUrl"=> targetUrl
        }
      })
      {:ok, response} = Stex.post(client.api_base <> "apps", body, client.headers)

      response
      |> Stex.parse_res
  end

end
