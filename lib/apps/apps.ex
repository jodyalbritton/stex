defmodule Stex.Apps do
  @moduledoc """
  Manipulate APPS using the SmartThings API
  """

  @doc """
  List all apps
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

    Stex.get_list("apps", client.headers, [params: new_opts])
    |> Stex.handle_response()
  end

  @doc """
   Show app

  ## Examples
      iex> Stex.Apps.show(client, app_id)
  """
  def show(client, app_id) do
    app =
    Stex.get_single("apps/#{app_id}", client.headers)
    |> Stex.handle_response()

    %{ client: client, app: app}
  end


  @doc """
   Delete an App
  """
  def delete(client, app_id) do
    Stex.delete_single("apps/#{app_id}", client.headers)
    |> Stex.handle_response()
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

      #Look at the response
      IO.inspect response
      response
      |> Stex.parse_res
  end

  @doc """
  Update an App
  """
  def updateWebhookSmartApp(client, connector) do
    body = Poison.encode!(%{
        "appName" => connector.app_name,
        "displayName"=> connector.display_name,
        "description"=> connector.description,
        "singleInstance"=> false,
        "appType" => "WEBHOOK_SMART_APP",
        "webhookSmartApp"=> %{
          "targetUrl"=> connector.target_url
        }
      })
      {:ok, response} = Stex.put(client.api_base <> "apps/#{connector.app_id}", body, client.headers)

      #Look at the response
      IO.inspect response
  end

  @doc """
  Create the authentication scopes for a new connector app.
  """
  def set_auth_scopes(client, app) do
    body = Poison.encode!(%{
        "scope" => [
          "r:devices:*",
          "l:devices",
          "l:installedapps",
          "r:installedapps:*",
          "r:schedules",
          "w:schedules"
          ],
        "clientName" => app.displayName
      })
      {:ok, response} = Stex.put(client.api_base <> "apps/#{app.appId}/oauth", body, client.headers)

      response
      |> Stex.parse_res
  end

end
