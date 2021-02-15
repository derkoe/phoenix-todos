defmodule TodosWeb.TodoLive.ItemComponent do
  use TodosWeb, :live_component

  @impl true
  @spec update(maybe_improper_list | map, Phoenix.LiveView.Socket.t()) ::
          {:ok, Phoenix.LiveView.Socket.t()}
  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end

end
