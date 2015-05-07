defmodule ZeePipe do
  def clean(s) do
    String.slice(s, 1..-2)
  end

  def extract_row(row) do
    [dna, gender, _, _, _, _, _, _, _, _, _, _, weight, _, _, _, _] = row
    {clean(dna), clean(gender), clean(weight)}
  end

  def is_dna_match(dna) do
    String.contains?(dna, "TAGTAAG")
  end

  def doit do
    File.stream!("/tmp/medical_screening_samples.csv")
      |> Stream.map(fn s -> String.split(s, ",") end)
      |> Stream.map(&extract_row/1)
      |> Stream.map(fn {d,g,w} -> {is_dna_match(d),g,w} end)
      |> Enum.take(5)
  end


  def init do
    :ok
  end

  def dna_count(sequence) do
    :not_implemented
  end
end

