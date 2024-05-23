defmodule TaskManagementWeb.TaskController do
  use TaskManagementWeb, :controller

  alias TaskManagement.TaskList
  alias TaskManagement.TaskList.Task

  action_fallback TaskManagementWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    tasks = TaskList.list_task_from_user(user_id)
    render(conn, :index, tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do

    case TaskList.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ~p"/api/tasks/#{task}")
        |> render("show.json", task: task)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = TaskList.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = TaskList.get_task!(id)

    case TaskList.update_task(task, task_params) do
      {:ok, task} ->
        render(conn, "show.json", task: task)
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = TaskList.get_task!(id)
    with {:ok, %Task{}} <- TaskList.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end

end
