defmodule TaskManagement.EtsRepo.TaskEts do
  alias TaskManagement.TaskList

  def child_spec(_opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :create_and_insert_tasks_ets, []},
      type: :worker,
      restart: :temporary,
      shutdown: 500
    }
  end

  # Function to insert tasks into ETS
  def create_and_insert_tasks_ets() do
    :ets.new(__MODULE__, [:public, :named_table])

    tasks = TaskList.list_tasks()
    grouped_tasks = group_tasks_by_user(tasks)

    Enum.each(grouped_tasks, fn {user_id, list_of_task} ->
      :ets.insert(__MODULE__, {user_id, list_of_task})
    end)

    {:ok, self()}
  end

  # Function to retrieve tasks for a user from ETS
  def get_tasks_for_user(user_id) do
    :ets.lookup(__MODULE__, user_id)
  end

  # Function to delete tasks for a user from ETS
  def delete_tasks_for_user(user_id) do
    :ets.delete(__MODULE__, user_id)
  end

  # Function to delete a specific task for a user from ETS
  def delete_task_for_user(user_id, task_id) do
    :ets.update_counter(__MODULE__, user_id, {task_id, -1})
  end

  # Function to group tasks by user ID
  def group_tasks_by_user(tasks) do
    Enum.group_by(tasks, &(&1.user_id))
  end

end
