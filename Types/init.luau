-- !strict

export type Client = {
	new: () -> (),
	SetNetwork: (string) -> (),
	Start: (Client) -> (),
}

export type Server = {
	new: () -> (),
	SetNetwork: (string) -> (),
	Start: (Server) -> (),
}

export type Framework = {
	CreateClient: () -> Client,
	CreateServer: () -> Server,
}

return {}
