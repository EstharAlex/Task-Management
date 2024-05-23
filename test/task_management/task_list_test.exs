defmodule TaskManagement.TaskListTest do
  use TaskManagement.DataCase

  alias TaskManagement.TaskList

  describe "tasks" do
    alias TaskManagement.TaskList.Task

    import TaskManagement.TaskListFixtures

    @invalid_attrs %{status: nil, description: nil, title: nil, due_date: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert TaskList.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert TaskList.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{status: "some status", description: "some description", title: "some title", due_date: ~D[2024-05-22]}

      assert {:ok, %Task{} = task} = TaskList.create_task(valid_attrs)
      assert task.status == "some status"
      assert task.description == "some description"
      assert task.title == "some title"
      assert task.due_date == ~D[2024-05-22]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskList.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{status: "some updated status", description: "some updated description", title: "some updated title", due_date: ~D[2024-05-23]}

      assert {:ok, %Task{} = task} = TaskList.update_task(task, update_attrs)
      assert task.status == "some updated status"
      assert task.description == "some updated description"
      assert task.title == "some updated title"
      assert task.due_date == ~D[2024-05-23]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskList.update_task(task, @invalid_attrs)
      assert task == TaskList.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = TaskList.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> TaskList.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = TaskList.change_task(task)
    end
  end

  describe "task_status_tracks" do
    alias TaskManagement.TaskList.TaskStatusTrack

    import TaskManagement.TaskListFixtures

    @invalid_attrs %{status_change: nil, changed_datetime: nil, task_id: nil}

    test "list_task_status_tracks/0 returns all task_status_tracks" do
      task_status_track = task_status_track_fixture()
      assert TaskList.list_task_status_tracks() == [task_status_track]
    end

    test "get_task_status_track!/1 returns the task_status_track with given id" do
      task_status_track = task_status_track_fixture()
      assert TaskList.get_task_status_track!(task_status_track.id) == task_status_track
    end

    test "create_task_status_track/1 with valid data creates a task_status_track" do
      valid_attrs = %{status_change: "some status_change", changed_datetime: ~N[2024-05-22 11:11:00], task_id: 42}

      assert {:ok, %TaskStatusTrack{} = task_status_track} = TaskList.create_task_status_track(valid_attrs)
      assert task_status_track.status_change == "some status_change"
      assert task_status_track.changed_datetime == ~N[2024-05-22 11:11:00]
      assert task_status_track.task_id == 42
    end

    test "create_task_status_track/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TaskList.create_task_status_track(@invalid_attrs)
    end

    test "update_task_status_track/2 with valid data updates the task_status_track" do
      task_status_track = task_status_track_fixture()
      update_attrs = %{status_change: "some updated status_change", changed_datetime: ~N[2024-05-23 11:11:00], task_id: 43}

      assert {:ok, %TaskStatusTrack{} = task_status_track} = TaskList.update_task_status_track(task_status_track, update_attrs)
      assert task_status_track.status_change == "some updated status_change"
      assert task_status_track.changed_datetime == ~N[2024-05-23 11:11:00]
      assert task_status_track.task_id == 43
    end

    test "update_task_status_track/2 with invalid data returns error changeset" do
      task_status_track = task_status_track_fixture()
      assert {:error, %Ecto.Changeset{}} = TaskList.update_task_status_track(task_status_track, @invalid_attrs)
      assert task_status_track == TaskList.get_task_status_track!(task_status_track.id)
    end

    test "delete_task_status_track/1 deletes the task_status_track" do
      task_status_track = task_status_track_fixture()
      assert {:ok, %TaskStatusTrack{}} = TaskList.delete_task_status_track(task_status_track)
      assert_raise Ecto.NoResultsError, fn -> TaskList.get_task_status_track!(task_status_track.id) end
    end

    test "change_task_status_track/1 returns a task_status_track changeset" do
      task_status_track = task_status_track_fixture()
      assert %Ecto.Changeset{} = TaskList.change_task_status_track(task_status_track)
    end
  end
end
