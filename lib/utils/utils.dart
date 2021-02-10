date2br(String date) =>
    '${DateTime.parse(date).day < 10 ? '0${DateTime.parse(date).day}' : DateTime.parse(date).day}/'
    '${DateTime.parse(date).month < 10 ? '0${DateTime.parse(date).month}' : DateTime.parse(date).month}/'
    '${DateTime.parse(date).year}';
