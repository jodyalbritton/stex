defmodule Stex.Subscriptions do
  @moduledoc """
  Handle all subcriptions for devices on the SmartThings platform
  """


  @doc """
   List all subcriptions for a SmartApp

   Max: 200 by default will return up to 200 subscriptions.


   ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> Stex.Subscriptions.list(client, app_id)
  """
  def list(client, app_id) do

    response = Stex.get!(client.api_base <> "installedapps/#{app_id}/subscriptions", client.headers)

    IO.inspect response
    if response.body != "" do
      final =
      response
      |> Stex.parse_res


      final.items
    end


  end

  @doc """
  Show Subscription

  ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> Stex.Devices.show(client, "some-app-id", "some-sub-id")
  """
  def show(client, app_id, subscription_id) do
    response = Stex.get!(client.api_base <> "installedapps/#{app_id}/#{subscription_id}", client.headers)

    device =
    response
    |> Stex.parse_res

    %{client: client, device: device}
  end

  @doc """
  Create an APP
  """

  def createSubscription(client, app_id, device_id, componentId, capability, attribute, stateChangeOnly, value) do
    body = Poison.encode!(%{
        "sourceType" => "DEVICE",
        "device" => %{
          "deviceId" => device_id,
          "componentId" => componentId,
          "capability" => capability,
          "attribute" => attribute,
          "stateChangeOnly" => stateChangeOnly,
          "value" => value
        }
      })
      {:ok, response} = Stex.post(client.api_base <> "installedapps/#{app_id}/subscriptions", body, client.headers)

      #Look at the response
      IO.inspect response
      response
      |> Stex.parse_res
  end


end
