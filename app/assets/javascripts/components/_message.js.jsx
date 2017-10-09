function Message(props) {
  const classname = "message " + props.direction;

  return (
    <div className={classname}>
      <span>{props.body}</span>
    </div>
  );
}
