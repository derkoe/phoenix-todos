defmodule TodosWeb.TodoLive.Index do
  use TodosWeb, :live_view

  alias Todos.TodoList

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :all, _params) do
    socket
    |> assign(:page_title, "All")
    |> assign(:todos , TodoList.list_todos())
  end

  defp apply_action(socket, :active, _params) do
    socket
    |> assign(:page_title, "Active")
    |> assign(:todos , TodoList.list_todos(false))
  end

  defp apply_action(socket, :completed, _params) do
    socket
    |> assign(:page_title, "Completed")
    |> assign(:todos , TodoList.list_todos(true))
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    todo = TodoList.get_todo!(id)
    {:ok, _} = TodoList.delete_todo(todo)

    {:noreply, assign(socket, :todos, list_todos())}
  end

  @impl true
  def handle_event("toggle", %{"id" => id}, socket) do
    todo = TodoList.get_todo!(id)
    {:ok, _} = TodoList.update_todo(todo, %{completed: !todo.completed})

    {:noreply, assign(socket, :todos, list_todos())}
  end

  @impl true
  def handle_event("clear-completed", %{}, socket) do
    TodoList.clear_completed()

    {:noreply, assign(socket, :todos, list_todos())}
  end

  def handle_info({:updated_todo, todo, todo_params}, socket) do
    TodoList.update_todo(todo, todo_params)
    {:noreply, assign(socket, :todos, list_todos())}
  end

  defp list_todos do
    TodoList.list_todos()
  end
end
