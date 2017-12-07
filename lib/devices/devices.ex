defmodule Stex.Devices do
  @moduledoc """
  SmartThings Devices API endpoint library
  """

  @doc """
   List all authorized devices

   Max: 200 by default will return up to 200 devices.


   ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> Stex.Devices.list(client)
  """
  def list(client) do
    options = [
      params: %{
        max: "200"
      }
    ]


    response = Stex.get!(client.api_base <> "devices", client.headers, options)
    final =
    response
    |> Stex.parse_res


    final.items
  end

  @doc """
  SmartThings built in endpoint for finding devices based on capability

  Max: 200 by default will return up to 200 devices.
  ** Curently Broken! **

  ## Examples
     iex> client = Stex.connect(your_access_token)
     iex> Stex.Devices.list_by_capability(client, "powerMeter")
  """
  def list_by_capability(client, capability) do
    options = [
      params: %{
        max: "200",
        capability: "#{capability}"
      }
    ]
    response = Stex.get!(client.api_base <> "devices", client.headers,options)

    final =
    response
    |> Stex.parse_res


    final.items
  end

  @doc """
   Show device

  ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> Stex.Devices.show(client, "some-device-id")
  """
  def show(client, device_id) do
    response = Stex.get!(client.api_base <> "devices/#{device_id}", client.headers)

    device =
    response
    |> Stex.parse_res

    %{client: client, device: device}
  end


  @doc """
   Get the current status of all of a device's component's attributes.
   The results may be filtered if the requester only has permission to view a
   subset of the device's components or capabilities. If the token is for
   a SmartApp that created the device then it implicitly has permission for this api.


   This function is chainable
   
    ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> device = Stex.Devices.show(some_device_id)
      iex> status = device |> show_status
  """
  def show_status(%{device: device, client: client}) do
    response = Stex.get!(client.api_base <> "devices/#{device.deviceId}/status", client.headers)
    response
    |> Stex.parse_res
  end





  @doc """
   Get the status of all attributes of a the component. The results may be
   filtered if the requester only has permission to view a subset of the component's capabilities.
   If the token is for a SmartApp that created the device then it implicitly has permission for this api.


   This function is chainable

   ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> device = Stex.Devices.show(client, "some-device-id")
      iex> component_status = device |> show_component_status("main")
  """
  def show_component_status(%{device: device, client: client}, component_id) do
    response = Stex.get!(client.api_base <> "devices/#{device.deviceId}/components/#{component_id}/status", client.headers)
    response.body
  end


  @doc """
   Get the current status of a device component's capability. If the token is
   for a SmartApp that created the device then it implicitly has permission for this api.

   ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> device = Stex.Devices.show(client, "some-device-id")
      iex> component_status = device |> show_capability_status("main", "powerMeter")
  """
  def show_capability_status(%{device: device, client: client}, component_id, capability_id) do
    response = Stex.get!(client.api_base <> "devices/#{device.deviceId}/components/#{component_id}/capabilities/#{capability_id}/status", client.headers)
    response
    |> Stex.parse_res
  end


  @doc """
    Filter utility for finding devices with the specified capability.

    ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> list = Stex.Devices.list(client)
      iex> devices = Stex.Devices.filter_by_capability(list, "powerMeter")
  """
  def filter_devices_by_capability(devices, capability) do
    filtered = []
    new_list =
    for device <- devices do
      if find_by_cap(List.first(device.components).capabilities, %{id: capability}) == true do
        [device | filtered]
      end
    end
    List.flatten(Enum.filter(new_list, & !is_nil(&1)))
  end
  # Utility function for finding the members of a list
  defp find_by_cap(list, cap) do
    Enum.member?(list, cap)
  end
end
