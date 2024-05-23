defmodule TaskManagement.TaskList.TaskStatusTrack do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task_status_tracks" do
    field :status_change, :string
    field :changed_datetime, :naive_datetime
    field :task_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task_status_track, attrs) do
    task_status_track
    |> cast(attrs, [:status_change, :changed_datetime, :task_id])
    |> validate_required([:status_change, :changed_datetime, :task_id])
  end
end
