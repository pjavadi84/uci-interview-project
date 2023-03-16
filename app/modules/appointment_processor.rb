module AppointmentProcessor
    require 'csv'

  def process_file(file_path)
    appointments = []
    CSV.foreach(file_path, headers: true) do |row|
      appointment = build_appointment(row)
      appointments << appointment if appointment
    end
    appointments
  end

  private

  def build_appointment(row)
    start_date, end_date = row['appointment_period'].split('|').map { |d| Date.parse(d) }
    return nil if end_date < Date.today

    appointments = []
    appointments << build_single_appointment(row, start_date, end_date)

    for i in 1..4
      next if row["department_id_#{i}"].nil?

      start_date, end_date = row["appointment_period_#{i}"].split('|').map { |d| Date.parse(d) }

      next if end_date < Date.today

      appointments << build_single_appointment(row, start_date, end_date, i)
    end

    appointments
  end

  def build_single_appointment(row, start_date, end_date, index = nil)
    {
      employee_id: row['employee_id'],
      name: row['name'],
      department_id: row[index ? "department_id_#{index}" : 'department_id'],
      title_code: row[index ? "title_code_#{index}" : 'title_code'],
      step: row[index ? "step_#{index}" : 'step'],
      appt_begin_date: start_date.strftime('%m/%d/%Y'),
      appt_end_date: end_date.strftime('%m/%d/%Y')
    }
  end
  
end