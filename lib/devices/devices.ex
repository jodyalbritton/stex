defmodule Stex.Devices do
  @moduledoc """
  SmartThings Devices API endpoint library
  """

  @doc """
   List all authorized devices

   Accepts optional params list.

   Max - Maximum number of devices returned. Default is 200 Accepts one [max="10"]
   Capability - Filter based on capability. Accepts multiple [...capability="1", capability="2"]
   LocationId - Filter based on LocationId Accepts multiple [...locationId="1", locationId="2"]
   DeviceId   - Filter based on DeviceId. Accepts multiple [...deviceId="1", deviceId="2" ]
   CapabilitiesMode - Set the way capabilities are filtered Accepts one of "And" / "Or" [capabilitiesMode="and"]

   [
     max: "integer",
     capability: "string",
     locationId: "string",
     deviceId: "string",
     capabilitiesMode: "string"
   ]

   ## Examples
      iex> client = Stex.connect(your_access_token)

      All Devices
      iex> Stex.Devices.list(client)

      Limit Devices to 10
      iex> Stex.Devices.list(client, [max: "10"])

      Filter on a capability
      iex> Stex.Devices.list(client, [capability: "powerMeter"])

      Multiple Params
      iex> Stex.Devices.list(client, [max: "10", capability="powerMeter", capability="switch"])

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

    Stex.get_list("devices", client.headers, [params: new_opts])
    |> Stex.handle_response()
  end


  @doc """
   Show device

  ## Examples
      iex> client = Stex.connect(your_access_token)
      iex> Stex.Devices.show(client, "some-device-id")
  """
  def show(client, device_id) do
    device =
    Stex.get_single("devices/#{device_id}", client.headers)
    |> Stex.handle_response()

    %{ client: client, device: device}
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
    Stex.get_single("devices/#{device.deviceId}/status", client.headers)
    |> Stex.handle_response()
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
    Stex.get_single("devices/#{device.deviceId}/components/#{component_id}/status", client.headers)
    |> Stex.handle_response()
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
    Stex.get_single("devices/#{device.deviceId}/components/#{component_id}/capabilities/#{capability_id}/status", client.headers)
    |> Stex.handle_response()
  end
end
