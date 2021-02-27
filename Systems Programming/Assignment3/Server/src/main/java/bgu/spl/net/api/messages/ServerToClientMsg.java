package bgu.spl.net.api.messages;

public class ServerToClientMsg implements Message {
	private short opcode;
	
	public ServerToClientMsg(short opcode) {
		this.opcode = opcode;
	}
	
	public short getOpcode() {
		return this.opcode;
	}
	
}
