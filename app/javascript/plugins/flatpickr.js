import flatpickr from "flatpickr";

flatpickr(".screening_session_time", {
  minDate: "today",
  time_24hr: true
});
flatpickr(".screening_closing_time", {
  minDate: "today",
  time_24hr: true
});
