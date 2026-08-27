#let name = sys.inputs.at("name", default: "Default user(?) name") // user? technically a user right? or not...
#let id = sys.inputs.at("id", default: "Default Roll number")
#let semester = sys.inputs.at("semester", default: "Semester text")
#let subject = sys.inputs.at("subject", default: "Default subject title")
#let title = sys.inputs.at("title", default: "Default Doc Type")
#let professor = sys.inputs.at("professor", default: "Professor's name")
#let principal = sys.inputs.at("principal", default: "Principal's name")

#set page(
  paper: "a4",
  background: box(
    inset: 10mm,
    width: 100%,
    height: 100%,
    rect(
      fill: none,
      stroke: 1mm + black,
      width: 100%,
      height: 100%,
      radius: 1mm,
    ),
  ),
  margin: 15mm,
)
#set text(
  font: "IBM Plex Sans",
  size: 14pt,
)

#align(
  center,
  stack(
    dir: ttb,
    spacing: 15pt,
    image(
      "/logo.webp",
      fit: "contain",
      width: 30mm,
    ),
    text(
      weight: "bold",
      size: 24pt,
    )[
      EAST WEST SCHOOL OF BUSINESS MANAGEMENT
    ],
    upper(
      text(
        weight: "bold",
        size: 20pt,
        subject,
      ),
    ),
    upper(
      text(
        weight: "bold",
        size: 18pt,
        title,
      ),
    ),
    v(1fr),
    align(
      right,
      stack(
        dir: ttb,
        spacing: 10pt,
        [By: *#name*,],
        [#id,],
        [#semester,],
        [Bachelor of Computer Applications,],
      ),
    ),
    rect(
      width: 100%,
      height: 1mm,
      fill: black,
      radius: 100%,
    ),
    v(36mm),
    grid(
      columns: (1fr, 1fr),
      rows: (8mm, 8mm),
      align(
        left,
        text(
          size: 16pt,
          weight: "bold",
        )[
          Principal
        ],
      ),
      align(
        right,
        text(
          size: 16pt,
          weight: "bold",
        )[
          HOD
        ],
      ),

      align(
        left,
        principal,
      ),
      align(
        right,
        professor,
      ),
    ),
  ),
)
