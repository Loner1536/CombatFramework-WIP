-- !strict

export type Client = {
	new: () -> Client,
	Constructor: (Client) -> Client,

	SetNetwork: (Client, Instance) -> Client,
	
	Start: (Client) -> Client,
}
export type Server = {
	new: () -> Server,
	Constructor: (Server) -> Server,

	SetNetwork: (Server, Instance) -> Server,
	SetFusion: (Server, Instance) -> Server,
	SetFusionUtils: (Server, Instance) -> Server,

	Start: (Server) -> Server,
}

export type Framework = {
	CreateClient: () -> Client,
	CreateServer: () -> Server,
}

return {}
