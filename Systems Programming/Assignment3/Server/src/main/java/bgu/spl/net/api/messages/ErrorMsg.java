package bgu.spl.net.api.messages;

public class ErrorMsg extends ServerToClientMsg {
	private short msgOpcode;
	
	public ErrorMsg(short msgOpcode) {
		super((short)11);
		this.msgOpcode = msgOpcode;
	}
	
	public short getMsgOpcode() {
		return this.msgOpcode;
	}
	
	
}
