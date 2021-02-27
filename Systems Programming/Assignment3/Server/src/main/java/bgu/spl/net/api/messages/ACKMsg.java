package bgu.spl.net.api.messages;

public class ACKMsg extends ServerToClientMsg {
	private short msgOpcode;

	public ACKMsg(short msgOpcode) {
		super((short)10);
		this.msgOpcode = msgOpcode;
	}
	
	public short getMsgOpcode() {
		return this.msgOpcode;
	}
}
