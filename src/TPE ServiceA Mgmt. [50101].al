codeunit 50101 "TPE ServiceA Mgmt." implements "TPE IService"
{
    [EventSubscriber(ObjectType::Codeunit, codeunit::"TPE Service Mgmt.", 'OnDiscovery', '', true, true)]
    local procedure OnDiscovery()
    var
        Services: Record "TPE Service";
        ModuleInf: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(ModuleInf);

        Services.init;
        Services.Name := 'Service1';
        Services."App Name" := ModuleInf.Name;
        Services."App Id" := ModuleInf.Id;
        if not Services.insert then Services.Modify();

        //sender.Update(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TPE Service Mgmt.", 'OnGetCodeunit', '', true, true)]
    local procedure OnGetCodeunit(AppId: Guid; var ServiceCU: Interface "TPE IService")
    var
        ModuleInf: ModuleInfo;
        this: Codeunit "TPE ServiceA Mgmt.";
    begin
        NavApp.GetCurrentModuleInfo(ModuleInf);
        if AppId = ModuleInf.Id then begin
            ServiceCU := this;
        end;
    end;

    procedure ShowInitMessage()
    begin
        Message('Init Message from Service 1');
    end;
}