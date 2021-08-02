@react.component
let make = () =>
  <div>
    /* <section> <App value="Test" /> </section> */
    <section> <FunctorTest title="Test prop pass" /> </section>
    <FetchComp url="https://61085becd73c6400170d391e.mockapi.io/names" />
  </div>
