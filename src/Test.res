type props = {title: string}
let make = (props: props) => {
  let (title, _) = React.useState(_ => props.title)
  <h1> {title |> React.string} </h1>
}

@obj external makeProps: (~title: string, unit) => props = ""
