function Message(props) {
  let classname = "message " + props.direction
  return ( 
    <div className={classname}>
      <span>{props.body}</span>
    </div>
  ); 
}
