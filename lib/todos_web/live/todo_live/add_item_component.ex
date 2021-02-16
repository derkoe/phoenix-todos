defmodule TodosWeb.TodoLive.AddItem do
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
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~L"""
    <%= f = form_for @changeset, "#",
      id: "new-todo",
      phx_target: @myself,
      phx_submit: "new" %>
      <%= text_input f, :title , class: "new-todo", placeholder: "What needs to be done?", autofocus: "" %>
    </form>
    """
  end

  @impl true
  def handle_event("new", %{"todo" => todo_params}, socket) do
    add_todo(socket, todo_params)
  end

  defp add_todo(socket, todo_params) do
    case TodoList.create_todo(todo_params) do
      {:ok, _todo} ->
        {:noreply, push_redirect(socket, to: "/todos")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
