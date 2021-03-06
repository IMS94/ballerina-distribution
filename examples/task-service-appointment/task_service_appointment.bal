import ballerina/io;
import ballerina/task;

// The [`task:AppointmentConfiguration`](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/task/latest/task/records/AppointmentConfiguration) record of the task listener.
task:AppointmentConfiguration appointmentConfiguration = {
    // This CRON expression will schedule the appointment every second.
    cronExpression: "* * * * * ?",
    // Number of recurrences will limit the number of times the timer runs.
    noOfRecurrences: 5
};

// Initialize the listener using the pre-defined configurations.
listener task:Listener appointment = new (appointmentConfiguration);

int reminderCount = 0;

// Creating a service bound to the task listener.
service on appointment {
    // This resource triggers when the appointment is due.
    remote function onTrigger() {
        reminderCount += 1;
        io:println("Schedule is due - Reminder: ", reminderCount);
    }

}
