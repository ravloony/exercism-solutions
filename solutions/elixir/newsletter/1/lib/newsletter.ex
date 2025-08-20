defmodule Newsletter do
  def read_emails(path) do
    case File.read(path) do
      {:ok, result} -> String.split(result)
      {:error, _} -> []
    end
  end

  def open_log(path) do
    case File.open(path, [:write]) do
      {:ok, pid} -> pid
    end
  end

  def log_sent_email(pid, email) do
    IO.write(pid, email <> "\n")
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    log_pid = open_log(log_path)
    emails_path
      |> read_emails()
      |> Enum.each(fn email -> case send_fun.(email) do
             :ok -> log_sent_email(log_pid, email)
             :error -> nil
           end
         end)
    close_log(log_pid)
  end
end
