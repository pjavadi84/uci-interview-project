class AppointmentsController < ApplicationController
  include AppointmentProcessor

  def index
    appointments = AppointmentProcessor.new.process_file('/Users/pouyajavadi/Downloads/faculty_appointments.csv')
    send_data appointments.to_csv, filename: 'current_appointments.csv'
  end

end