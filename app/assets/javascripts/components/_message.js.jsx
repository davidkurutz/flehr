function Message(props) {
  let classname = "message " + props.direction
  return ( 
    <div className={classname}>
      {props.body}
    </div>
  ); 
}
