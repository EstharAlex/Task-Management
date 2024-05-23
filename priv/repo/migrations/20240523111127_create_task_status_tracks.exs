defmodule TaskManagement.Repo.Migrations.CreateTaskStatusTracks do
  use Ecto.Migration

  def change do
    create table(:task_status_tracks) do
      add :status_change, :string
      add :changed_datetime, :naive_datetime
      add :task_id, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
