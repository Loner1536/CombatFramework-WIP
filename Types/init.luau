-- !strict

export type Client = {
	new: () -> (),
	SetNetwork: (Path: string) -> (),
	Start: (Client) -> (),
}

export type Server = {
	new: () -> (),
	SetNetwork: (Path: string) -> (),
	SetFusion: (Path: string) -> (),
	Start: (Server) -> (),
}

export type Charcter = {
	new: (Character: Model) -> (),
	GetCharacterByModel: (Model) -> Charcter,
}
export type Framework = {
	CreateClient: () -> Client,
	CreateServer: () -> Server,
	Character: Charcter,
}

return {}
