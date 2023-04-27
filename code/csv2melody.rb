# Require the 'csv' library to read the CSV file.
# Note: Sonic Pi does not have built-in support for reading CSV files. 
# You might need to use an alternative method to read the CSV file, 
# such as using an external script to send OSC messages with the CSV data to Sonic Pi.
require 'csv'

# Read the CSV file and store the data in the variable `csv_data`.
# Replace "your_file.csv" with the path to your CSV file.
csv_data = CSV.read("your_file.csv", headers: true)

# Define a function `play_melody_from_csv` that takes a single argument, `data`.
# This function will be responsible for playing the melody based on the provided CSV data.
define :play_melody_from_csv do |data|
  # Iterate through each row in the CSV data.
  data.each do |row|
    # Extract the values from each column in the current row.
    distance = row[0].to_f # Distance (column 1)
    pan = row[1].to_f      # Pan value (column 2)
    start_time = row[2].to_f # Start time (column 3)
    duration = row[3].to_f   # Duration (column 4)

    # Map distance to amplitude (assuming larger distance means lower amplitude)
    amplitude = 1 / (1 + distance)

    # Generate a random MIDI note number between 60 and 80
    note = rrand_i(60, 80)

    # Use an `in_thread` block to schedule the note to play at the specified start time.
    in_thread do
      # Sleep for the specified start time before playing the note.
      sleep start_time

      # Apply the pan effect using the `with_fx` block.
      # Set the pan value to the value from the CSV file.
      with_fx :pan, pan: pan do
        # Use the `synth` function to play the note with the specified amplitude and duration.
        synth :sine, note: note, amp: amplitude, release: duration
      end
    end
  end
end

# Call the `play_melody_from_csv` function and pass in the CSV data.
play_melody_from_csv(csv_data)
