defmodule TodosWeb.TodoLive.ItemComponent do
  use TodosWeb, :live_component
  alias Todos.TodoList

  @impl true
  @spec update(maybe_improper_list | map, Phoenix.LiveView.Socket.t()) ::
          {:ok, Phoenix.LiveView.Socket.t()}
  def update(assigns, socket) do
    changeset = TodoList.Todo.changeset(%TodoList.Todo{}, %{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("change", %{"todo" => todo_params}, socket) do
    send self(), {:updated_todo, socket.assigns.todo, todo_params}
    {:noreply, socket}
  end
end
