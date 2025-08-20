defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: opts) :: {:ok, opts :: opts} | {:error, error :: error}

  @callback handle_frame(dot :: dot, frame_number :: frame_number, opts :: opts) :: dot

  
  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end

    
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  def handle_frame(dot, frame_number, opts) do
    drop_opacity = rem(frame_number, 4) == 0
    case drop_opacity do
      true -> %{dot | opacity: dot.opacity / 2}
      _ -> dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  def init(opts)  do
    case Keyword.fetch(opts, :velocity) do
      {:ok, velocity } -> if is_number(velocity) do
          {:ok, opts}
        else
          {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
        end
      :error -> {:error, "The :velocity option is required, and its value must be a number. Got: nil"}
    end
  end

  def handle_frame(dot, frame_number, opts) do
    %{dot | radius: dot.radius + (frame_number - 1) * opts[:velocity]}
  end
end
