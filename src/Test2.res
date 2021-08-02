type props = {title: string}
let make = (props: props) => {
  <h1> {props.title |> React.string} </h1>
}

@obj external makeProps: (~title: string, unit) => props = ""
