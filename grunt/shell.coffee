module.exports =
  broccoli_test:
    command: "BROCCOLI_ENV=test broccoli build dist"
  broccoli_local:
    command: "BROCCOLI_ENV=local broccoli build dist"
  broccoli:
    command: "broccoli build dist"
