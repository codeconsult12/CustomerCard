// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!
tableextension 50145 interactionlogs extends "Interaction Log Entry"
{


    fields
    {
        field(50020; CallInitationTime;
        Time)
        {
            Caption = 'Call Initation Time';

        }
        field(50021; CallEndTime;
        Time)
        {
            Caption = 'Call End Time';

        }
        field(50022; PatientPhone;
        Text[12])
        {
            Caption = 'Patient Phone';


        }

        field(50023; PatientID;
        Text[12])
        {
            Caption = 'Patient ID';

        }
        field(50024; PatientName;
        Text[12])
        {
            Caption = 'Patient Name';

        }
        field(50027; CallInitationTime1;
        Time)
        {
            Caption = 'Call Initation Time';
            CalcFormula = lookup("Segment Line"."Time of Interaction" where("Contact No." = field("Contact No."), "Time of Interaction" = field("Time of Interaction")));
            FieldClass = FlowField;

        }
        field(50028; CallEndTime1;
        Time)
        {
            Caption = 'Call End Time';
            CalcFormula = lookup("Segment Line".CallEndTime where("Contact No." = field("Contact No."), "Time of Interaction" = field("Time of Interaction")));
            FieldClass = FlowField;

        }
        field(50029; PatientPhone1;
        Text[30])
        {
            Caption = 'Patient Phone';
            CalcFormula = lookup("Segment Line"."Contact Phone No." where("Contact No." = field("Contact No."), "Time of Interaction" = field("Time of Interaction")));
            FieldClass = FlowField;

        }

        field(50030; PatientID1;
        Text[2048])
        {
            Caption = 'Patient ID';
            CalcFormula = lookup("Segment Line"."Patient ID" where("Contact No." = field("Contact No."), "Time of Interaction" = field("Time of Interaction")));
            FieldClass = FlowField;

        }
        field(50031; PatientName1;
        Text[100])
        {
            Caption = 'Patient Name';
            CalcFormula = lookup("Segment Line"."Contact Name" where("Contact No." = field("Contact No."), "Time of Interaction" = field("Time of Interaction")));
            FieldClass = FlowField;
        }
        field(50025; Comments;
        Text[12])
        {

            Caption = 'Comments';

        }
        field(50026; Comments1;
        text[80])
        {
            AutoFormatType = 1;
            CalcFormula = lookup("Inter. Log Entry Comment Line".Comment where("Entry No." = field("Entry No.")));
            FieldClass = FlowField;
            Caption = 'Comments';

        }
        field(50032; SMSText;
        text[2048])
        {



            Caption = 'SMS Text';

        }


    }

}
pageextension 50100 InteractionLog extends "Interaction Log Entries"
{
    layout
    {



        addafter("Date")
        {
            field("CallInitationTime"; Rec."Time of Interaction")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Call Initation Time';
                Visible = Not isWelcomeCompany;


            }

            // field("CallEndTime"; Rec.CallEndTime1)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Call End Time';
            //     Visible = Not isWelcomeCompany;


            // }
            // field("ContactNo"; Rec.PatientPhone1)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Patient Phone';
            //     Visible = Not isWelcomeCompany;

            // }
            // field("PatientName"; Rec.PatientName1)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Patient Name';
            //     Visible = false;
            // }
            // field("PatientId"; Rec.PatientID1)
            // {

            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Patient ID';
            //     // TableRelation = Customer.Name;
            //     Visible = Not isWelcomeCompany;

            // }
            // field("PatientPhone"; Rec.PatientPhone)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Patient Phone';

            // }


        }

        addlast(Control1)
        {
            field("SMS TEXT";
            Rec.SMSText)
            {
                Caption = 'SMS Text';
                ApplicationArea = Basic, Suite;

                Visible = Not isWelcomeCompany;
            }
        }

        addafter("Salesperson Code")
        {
            field("Comments"; Rec.Comments1)
            {
                Caption = 'Comments';
                ApplicationArea = Basic, Suite;

                Visible = Not isWelcomeCompany;

            }
        }
        modify("Salesperson Code")
        {

            Caption = 'Agent Code';
            Visible = Not isWelcomeCompany;
        }
        // modify("Contact Name")
        // {
        //     Caption = 'Patient Name';
        // }
        modify("Contact No.")
        {
            // Visible = not isWelcomeCompany;
            // Visible = false;
            // Caption = salespersoncodecaption;
            // Caption = salespersoncodecaption;
            Visible = isWelcomeCompany;
        }

        modify("Contact Name")
        {
            Caption = 'Patient Name';
            // Visible = isWelcomeCompany;
        }


    }
    var
        salespersoncodecaption: Text[1000];

        isWelcomeCompany: Boolean;

    trigger OnOpenPage();
    begin

        isWelcomeCompany := true;

        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')
        then begin
            isWelcomeCompany := false;
            // Caption := Caption('Patients');

        end;
    end;

}


pageextension 50114 createinteraction extends "Create Interaction"
{
    layout
    {



        addbefore("Campaign Description")
        {

            field("PatientName"; Rec.PatientName)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Patient Name';
                Visible = Not isWelcomeCompany;

            }
            field("PatientPhone"; Rec."Contact Phone No.")

            {

                ApplicationArea = Basic, Suite;
                Caption = 'Patient Phone';
                Visible = Not isWelcomeCompany;
            }
            field("Provider Code"; Rec."Salesperson Code")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Provider Code';
                Visible = isWelcomeCompany;
                Enabled = isWelcomeCompany;

            }
            field("CallInitationTime"; Rec."Time of Interaction")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Call Initation Time';
                Visible = Not isWelcomeCompany;

            }


            // field("CallInitiationTime"; Rec."Time of Interaction")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = true;

            // }
            // field("CorrespondenceType"; Rec."Correspondence Type")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Visible = false;

            // field("CallEndTime"; Rec.CallEndTime)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Call End Time';

            // }

            // }
        }


        addafter("CallInitationTime")
        {
            field("CallEndTime"; Rec."CallEndTime")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Call End Time';
                Visible = Not isWelcomeCompany;
            }
        }

        modify("Time of Interaction")
        {
            Visible = isWelcomeCompany;
        }
        modify("Cost (LCY)")
        {
            Visible = isWelcomeCompany;
        }
        modify("Duration (Min.)")
        {
            Visible = isWelcomeCompany;
        }
        modify("Correspondence Type")
        {

            Visible = isWelcomeCompany;
        }


        modify("Campaign Response")
        {

            Visible = isWelcomeCompany;
        }
        modify("Campaign Target")
        {

            Visible = isWelcomeCompany;
        }


        modify("Information Flow")
        {

            Visible = isWelcomeCompany;
        }
        modify("Initiated By")
        {

            Visible = isWelcomeCompany;
        }
        modify("Campaign Description")
        {

            Visible = isWelcomeCompany;
        }
        modify("Interaction Successful")
        {

            Visible = isWelcomeCompany;
        }
        modify("Opportunity Description")
        {


            Visible = isWelcomeCompany;
        }
        modify("Evaluation")
        {

            Visible = isWelcomeCompany;
        }

    }
    var
        salespersoncodecaption: Text[1000];

        isWelcomeCompany: Boolean;

    trigger OnOpenPage();
    begin



        isWelcomeCompany := true;

        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')
          then begin
            isWelcomeCompany := false;
            // Caption := Caption('Patients');

        end;
    end;
}

tableextension 50144 segmentList extends "Segment Line"
{
    Caption = 'Work File';
    fields
    {
        field(50001; "Last Contact Date"; Date)
        {
            Caption = 'Last Contact Date';
            AutoFormatType = 1;
            CalcFormula = lookup(Contact."Last Contact Date" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50002; "Last Visit Date"; Date)
        {

            AutoFormatType = 1;
            Caption = 'Last Visit Date';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Last Visit Date" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50003; CallEndTime;
        Time)
        {
            Caption = 'Call End Time';

        }


        field(50004; "Patient ID";
        Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Patient ID';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Patient ID" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }


        field(50005; PatientName;
        Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Patient Name';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact.Name where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }
        field(50006; PCDoctor;
        Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'PC Doctor';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            TableRelation = Contact."PC Doctor" where("No." = field("Contact No."));

            //   FieldClass = FlowField;
        }

        field(50007; "ICD 1"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'ICD 1';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."ICD 1" where("No." = field("Contact No.")));
            FieldClass = FlowField;
        }

        field(50008; "ICD 2"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'ICD 2';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."ICD 2" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50009; "ICD 3"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'ICD 3';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."ICD 3" where("No." = field("Contact No.")));

            FieldClass = FlowField;

        }

        field(50010; "CPT 1"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'CPT 1';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."CPT 1" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50011; "CPT 2"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'CPT 2';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."CPT 2" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50012; "CPT 3"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'CPT 3';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."CPT 3" where("No." = field("Contact No.")));

            FieldClass = FlowField;

        }

        field(50013; "Insurance Carrier / Plan Name"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'Insurance Carrier / Plan Name';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Insurance Carrier / Plan Name" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50014; "PC Doctor"; code[2048])
        {
            AutoFormatType = 1;
            Caption = 'PC Doctor';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."PC Doctor" where("No." = field("Contact No.")));

            FieldClass = FlowField;

        }

        field(50015; "Patient First Name"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Patient First Name';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Patient First Name" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50016; "Patient Last Name"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Patient Last Name';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Patient Last Name" where("No." = field("Contact No.")));

            FieldClass = FlowField;

        }

        field(50017; "Sex"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Sex';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Sex" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50018; "Marital Status"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Marital Status';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Marital Status" where("No." = field("Contact No.")));

            FieldClass = FlowField;

        }

        field(50019; "Primary Language"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Primary Language';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Primary Language" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50020; "Race / Ethnicity"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Race / Ethnicity';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Race / Ethnicity" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }

        field(50021; "Employer"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Employer';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Employer" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }
        field(50022; "Emergency Contact"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Emergency Contact';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Emergency Contact" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }
        field(50023; "Emergency Contact Phone "; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Emergency Contact Phone';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Emergency Contact Phone " where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }
        field(50024; "Reason For Last Visit"; Text[2048])
        {
            AutoFormatType = 1;
            Caption = 'Reason For Last Visit';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Reason For Last Visit" where("No." = field("Contact No.")));

            FieldClass = FlowField;

        }
        field(50025; "Patient Balance"; Integer)
        {
            AutoFormatType = 1;
            Caption = 'Patient Balance';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Patient Balance" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }
        field(50026; "Deductible"; Integer)
        {
            AutoFormatType = 1;
            Caption = 'Deductible';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Deductible" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }
        field(50027; "Date of Birth"; Date)
        {
            AutoFormatType = 1;
            Caption = 'Date of Birth';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            CalcFormula = lookup(Contact."Date of Birth" where("No." = field("Contact No.")));

            FieldClass = FlowField;
        }
        field(50028; "Disposition Code New"; Text[2000])
        {
            AutoFormatType = 1;
            Caption = 'Disposition Code New';
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            TableRelation = "Disposition Code"."Disposotion Name";




            // FieldClass = FlowField;

        }
        field(50029; "Agent Code"; Code[20])
        {
            AutoFormatType = 1;
            Caption = 'Agent Code';
            CalcFormula = lookup("Interaction Log Entry"."Salesperson Code" where("Contact No." = field("Contact No.")));
            FieldClass = FlowField;
        }
        // field(50029; "Disposition Name"; Text[2000])
        // {
        //     AutoFormatType = 1;
        //     Caption = 'Disposition name';
        //     CalcFormula = lookup("Disposition Code"."Disposotion Name" WHERE("Code" = field("Disposition Code New")));



        //     FieldClass = FlowField;

        // }

    }
}

tableextension 50146 CrmExt extends Contact
{
    Caption = 'Patients';
    fields
    {
        field(50100; "Patient ID"; code[2048])
        {

        }
        field(50101; "ICD 1"; code[2048])
        {

        }

        field(50102; "ICD 2"; code[2048])
        {

        }

        field(50103; "ICD 3"; code[2048])
        {

        }

        field(50104; "CPT 1"; code[2048])
        {

        }

        field(50105; "CPT 2"; code[2048])
        {

        }

        field(50106; "CPT 3"; code[2048])
        {

        }

        field(50107; "Insurance Carrier / Plan Name"; code[2048])
        {

        }

        field(50108; "PC Doctor"; code[2048])
        {

        }

        field(50109; "Patient First Name"; Text[2048])
        {

        }

        field(50110; "Patient Last Name"; Text[2048])
        {

        }

        field(50111; "Sex"; Text[2048])
        {

        }

        field(50112; "Marital Status"; Text[2048])
        {

        }

        field(50113; "Primary Language"; Text[2048])
        {

        }

        field(50114; "Race / Ethnicity"; Text[2048])
        {

        }

        field(50115; "Employer"; Text[2048])
        {

        }
        field(50116; "Emergency Contact Phone "; Text[2048])
        {

        }
        field(50123; "Emergency Contact"; Text[2048])
        {

        }
        field(50117; "Reason For Last Visit"; Text[2048])
        {

        }
        field(50118; "Patient Balance"; Integer)
        {

        }
        field(50119; "Deductible"; Integer)
        {

        }
        field(50120; "Date of Birth"; Date)
        {

        }
        field(50121; "Last Visit Date"; Date)
        {

        }
        field(50122; "Last Contact Date"; Date)
        {

        }
        field(50128; "Last Contact Date1"; Date)
        {

        }

        //D
        field(50126; MaxInteractionDate; Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Interaction Log Entry".Date where("Contact No." = field("No."), "Contact Name" = field(Name)));

        }


        field(50124; "Call Initation Time"; Time)
        {
            FieldClass = FlowField;
            CalcFormula = max("Interaction Log Entry"."Time of Interaction" where(Date = field(MaxInteractionDate), "Contact Name" = field(Name)));
        }
        field(50125; "Call End Time"; Time)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Interaction Log Entry".CallEndTime where("Contact No." = field("No.")));
        }

        field(50127; "Interaction Agent"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Interaction Log Entry"."Salesperson Code" where("Time of Interaction" = field("Call Initation Time"), "Contact No." = field("No.")));
        }
        //D
    }
}

pageextension 50148 CrmExtContactList extends "Contact List"
{
    Caption = 'Contacts';
    AdditionalSearchTerms = 'Contacts,Patients';

    layout
    {
        modify("Salesperson Code")
        {
            Caption = 'Agent Code';
            ApplicationArea = Basic, Suite;
        }
        modify(Name)
        {
            Visible = iswelcomecompany;
        }
        modify("Phone No.")
        {
            Visible = iswelcomecompany;
        }
        addafter(Name)
        {
            field("Patient Name"; Rec.Name)
            {
                Caption = 'Patient Name';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Cell-Phone"; Rec."Mobile Phone No.")
            {
                Caption = 'Cell-Phone';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Home Phone"; Rec."Phone No.")
            {
                Caption = 'Home Phone';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;


            }
            field("DOB"; Rec."Date of Birth")
            {
                Caption = 'DOB';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Last Contact Date"; Rec.MaxInteractionDate)
            {
                Caption = 'Last Contact Date';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
                Editable = true;
            }
            field("Interaction Agent"; Rec."Interaction Agent")
            {
                Caption = 'Agent Code';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
                Editable = true;
            }



        }
        addafter("Territory Code")
        {

            field("Patient ID"; Rec."Patient ID")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("ICD 1"; Rec."ICD 1")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("ICD 2"; Rec."ICD 2")

            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("ICD 3"; Rec."ICD 3")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("CPT 1"; Rec."CPT 1")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("CPT 2"; Rec."CPT 2")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("CPT 3"; Rec."CPT 3")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Insurance Carrier / Plan Name"; Rec."Insurance Carrier / Plan Name")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("PC Doctor"; Rec."PC Doctor")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Patient First Name"; Rec."Patient First Name")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Patient Last Name"; Rec."Patient Last Name")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Sex"; Rec."Sex")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Primary Language"; Rec."Primary Language")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Race / Ethnicity"; Rec."Race / Ethnicity")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Employer"; Rec."Employer")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Emergency Contact"; Rec."Emergency Contact")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Emergency Contact Phone"; Rec."Emergency Contact Phone ")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Reason For Last Visit"; Rec."Reason For Last Visit")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("Patient Balance"; Rec."Patient Balance")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("Deductible"; Rec."Deductible")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Date of Birth"; Rec."Date of Birth")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Last Visit Date"; Rec."Last Visit Date")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

        }
        addafter("Patient ID")
        {
            field("Call Initation Time"; Rec."Call Initation Time")

            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;

            }
            field("Call End Time"; Rec."Call End Time")

            {
                ApplicationArea = All;
                Visible = NOT iswelcomecompany;

            }
        }




    }
    actions
    {


        modify(Action63)
        {
            Visible = isWelcomeCompany;
        }
        modify(Action64)
        {
            Visible = isWelcomeCompany;
        }
        modify("&Picture")
        {
            Visible = isWelcomeCompany;
        }
        modify(Action65)
        {
            Visible = isWelcomeCompany;
        }
        modify("C&ontact")
        {
            Visible = isWelcomeCompany;
        }
        modify("Business Relations")
        {
            Visible = isWelcomeCompany;
        }
        modify(Card)
        {
            Visible = isWelcomeCompany;
        }
        modify(Documents)
        {
            Visible = isWelcomeCompany;
        }
        modify(DiscountLines)
        {
            Visible = isWelcomeCompany;
        }

        modify(ActionGroupCRM)
        {
            Visible = isWelcomeCompany;

        }
        modify("Alternati&ve Address")
        {
            Visible = isWelcomeCompany;

        }
        modify("Closed Oppo&rtunities")
        {
            Visible = isWelcomeCompany;

        }
        modify(Tasks)
        {
            Visible = isWelcomeCompany;

        }
        modify(FullSyncWithExchange)
        {
            Visible = isWelcomeCompany;
        }


        modify("Create Opportunity")
        {
            Visible = isWelcomeCompany;

        }
        modify(CreateEmployee)
        {
            Visible = isWelcomeCompany;

        }


        modify(CreateFromCRM)
        {
            Visible = isWelcomeCompany;

        }


        modify(CreateInCRM)
        {
            Visible = isWelcomeCompany;

        }

        modify(Customer)
        {
            Visible = isWelcomeCompany;

        }

        modify("Contact Labels")
        {
            Visible = isWelcomeCompany;

        }

        modify(Create)
        {
            Visible = isWelcomeCompany;

        }
        modify(SyncWithExchange)
        {
            Visible = isWelcomeCompany;

        }
        modify("Sales Cycle Analysis")
        {
            Visible = isWelcomeCompany;

        }
        modify("Comp&any")
        {
            Visible = isWelcomeCompany;

        }
        modify(Coupling)
        {
            Visible = isWelcomeCompany;

        }
        modify(CRMGotoContact)
        {
            Visible = isWelcomeCompany;

        }
        modify(CRMSynchronizeNow)
        {
            Visible = isWelcomeCompany;

        }
        modify("Date Ranges")
        {
            Visible = isWelcomeCompany;

        }
        modify(Email)
        {
            Visible = isWelcomeCompany;

        }
        modify("Export Contact")
        {
            Visible = isWelcomeCompany;

        }
        modify("Create as")
        {
            Visible = isWelcomeCompany;

        }
        modify("F&unctions")
        {
            Visible = isWelcomeCompany;

        }
        modify("Industry Groups")
        {
            Visible = isWelcomeCompany;

        }
        modify("Interaction Log E&ntries")
        {
            Visible = isWelcomeCompany;

        }
        modify("Job Responsibilities")
        {
            Visible = isWelcomeCompany;

        }
        modify(WordTemplate)
        {
            Visible = isWelcomeCompany;

        }
        modify("Web Sources")
        {
            Visible = isWelcomeCompany;

        }
        modify("Open Oppo&rtunities")
        {
            Visible = isWelcomeCompany;
        }

        modify(Statistics)
        {
            Visible = isWelcomeCompany;
        }

        modify(Vendor)
        {
            Visible = isWelcomeCompany;
        }
        modify(Bank)
        {
            Visible = isWelcomeCompany;
        }
        modify(RelatedBank)
        {
            Visible = isWelcomeCompany;
        }
        modify(RelatedCustomer)
        {
            Visible = isWelcomeCompany;
        }
        modify(RelatedEmployee)
        {
            Visible = isWelcomeCompany;
        }
        modify(RelatedVendor)
        {
            Visible = isWelcomeCompany;
        }

        modify(NewSalesQuote)
        {
            Visible = isWelcomeCompany;
        }

        modify(ShowSalesQuotes)
        {
            Visible = isWelcomeCompany;
        }
        modify("Postponed &Interactions")
        {
            Visible = isWelcomeCompany;
        }
        modify("P&erson")
        {
            Visible = isWelcomeCompany;
        }
        modify("Pro&files")
        {
            Visible = isWelcomeCompany;
        }
        modify(MakePhoneCall)
        {
            Visible = isWelcomeCompany;
        }
        modify("Relate&d Contacts")
        {
            Visible = isWelcomeCompany;
        }
        modify("Related Information")
        {
            Visible = isWelcomeCompany;
        }
        modify("Co&mments")
        {
            Visible = isWelcomeCompany;
        }
        modify("Questionnaire Handout")
        {
            Visible = isWelcomeCompany;
        }
        modify("Create &Interaction")
        {
            Visible = isWelcomeCompany;

            ApplicationArea = RelationshipMgmt;
            Caption = 'Create &Interaction';

            Promoted = true;
            PromotedCategory = Process;
            ToolTip = 'Create an interaction with a specified contact.';




        }

        addfirst(navigation)
        {
            action(CreateInteraction)
            {
                ApplicationArea = RelationshipMgmt;


                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = NOT isWelcomeCompany;
                AccessByPermission = TableData Attachment = R;
                Caption = 'Create &Interaction';
                Image = CreateInteraction;
                // Promoted = true;
                // PromotedCategory = Process;
                ToolTip = 'Create an interaction with a specified contact.';

                trigger OnAction()
                begin
                    Rec.CreateInteraction;
                end;
            }
            action(CreateCall)
            {
                ApplicationArea = RelationshipMgmt;


                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = NOT isWelcomeCompany;
                AccessByPermission = TableData Attachment = R;
                Caption = 'Make a Call';
                Image = Calls;
                Scope = Repeater;
                ToolTip = 'Call the selected contact.';

                trigger OnAction()
                var
                    TAPIManagement: Codeunit TAPIManagement;
                begin
                    TAPIManagement.DialContCustVendBank(DATABASE::Contact, Rec."No.", Rec.GetDefaultPhoneNo(), '');
                end;

                // trigger OnAction()
                // var
                //     Result: Boolean;
                //     InteractionLog: Record "Interaction Log Entry";
                // begin
                //     if (rec."Phone No." <> '')

                //     then begin

                //         Result := DialpadCode(rec."No.", rec."Phone No.", rec."Mobile Phone No.", '6389307516846080');
                //         if (Result = true)
                //         then begin
                //             Message('Success Fully Calling on ' + rec."Mobile Phone No.");
                //             Interactionlog."Contact No." := Rec."No.";
                //             Interactionlog.PatientID := Rec."Patient ID";
                //             Interactionlog.Comments := 'Call';
                //             Interactionlog."Contact Name" := Rec.Name;
                //             Interactionlog."Contact Company Name" := Rec."Company Name";
                //             Interactionlog."Contact Via" := 'Call';
                //             Interactionlog."Time of Interaction" := Time;
                //             Interactionlog."Interaction Template Code" := 'OUTGOING';
                //             Interactionlog.Insert();
                //         end else begin
                //             Message('There is some error');
                //         end;
                //         //  DialpadCode(rec."No.", rec."Phone No.", rec."Mobile Phone No.", 'me');

                //     end else begin
                //         Message('Phone No. does not exist');
                //     end;

                // end;
            }
            action(SendMessage)
            {
                ApplicationArea = RelationshipMgmt;


                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = NOT isWelcomeCompany;
                AccessByPermission = TableData Attachment = R;
                Caption = 'Send Message';
                Image = SendMail;
                Scope = Repeater;
                ToolTip = 'Send message to selected contact.';


                trigger OnAction()

                var
                    Contacts: Record Contact;
                    SMSData: Record SMSDataTable;
                begin
                    if (rec."Mobile Phone No." <> '')
                                     then begin
                        SMSData.DeleteAll();
                        SMSData.ContactNo := rec."No.";
                        SMSData.MobileNo := rec."Mobile Phone No.";
                        SMSData.isSent := false;
                        SMSData.Insert();
                        //CurrPage.SetSelectionFilter(Contacts);
                        Commit();
                        REPORT.RunModal(REPORT::"Send SMS", true, true, SMSData);


                    end else begin
                        Message('Cell Phone number does not exist!');
                    end;

                    //     CLEAR(Mywindow);
                    //     Mywindow.OPEN('Input your nickname: #1#########');
                    //     mywindow.INPUT(1, myinputtext);
                    //     mywindow.CLOSE;
                    //     MESSAGE('Hello, %1', myinputtext);

                    // end;

                end;
            }
            action("Comments")
            {
                Visible = NOT isWelcomeCompany;
                ApplicationArea = RelationshipMgmt;
                Caption = 'Co&mments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                // PromotedCategory = Category4;
                RunObject = Page "Rlshp. Mgt. Comment Sheet";
                RunPageLink = "Table Name" = CONST(Contact),
                                  "No." = FIELD("No."),
                                  "Sub No." = CONST(0);
                ToolTip = 'View or add comments for the record.';
            }
        }




    }

    procedure CreateBasicAuthHeader(UserName: Text;
                Password:
                    Text):
            Text
    var

#pragma warning disable AL0432
        TempBlob: Record TempBlob;
#pragma warning restore AL0432

    begin
        TempBlob.WriteAsText(StrSubstNo('%1:%2', UserName, Password), TextEncoding::UTF8);
        exit(StrSubstNo('Basic %1', TempBlob.ToBase64String()));
    end;

    procedure DialpadCode(ContactNo: Code[20]; PhoneNo: Text[30]; CellNo: Code[30]; UserId: Text)
    Result: Boolean
    var
        Client: HttpClient;
        RequestHeaders: HttpHeaders;

        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        url: text;
        contentHeaders: HttpHeaders;
        body: Text;
    begin
        RequestHeaders := Client.DefaultRequestHeaders();
        //Message(UserId);
        //url := StrSubstNo('https://api.businesscentral.dynamics.com/v2.0/1a9533fb-c524-4eb7-96c8-fbdc362ac6a0/Sandbox/ODataV4/Company(''%1'')/General_Journals', CompanyName);
        body := '{"phone_number":"+1' + Delchr(DelChr(CellNo, '=', '-'), '=', ' ') + '","user_id":"' + UserId + '"}';
        //Message(body);
        url := StrSubstNo('https://dialpad.com/api/v2/call?apikey=SUbAMUyuR5S9p4ckyPy3LR4r3EWZgbk5v3nUzEtmJVHVgeJCeZU6WURBrvfTdgdcMRvPVmtvMBcxk8Hz83jD4bG9xzJng6bnAfrg');
        RequestContent.WriteFrom(body);
        Client.Post(url, RequestContent, ResponseMessage);
        ResponseMessage.Content().ReadAs(ResponseText);
        Message(ResponseText);
        if (ResponseMessage.IsSuccessStatusCode)
        then begin
            Result := true;
        end else begin
            Result := false;
        end;
    end;

    var

        result: list of [Text];
        // Client: HttpClient;
        // RequestHeaders: HttpHeaders;
        // body: Text;
        // RequestContent: HttpContent;
        // ResponseMessage: HttpResponseMessage;
        // RequestMessage: HttpRequestMessage;
        // // ResponseText: Text;
        // url: text;
        // // contentHeaders: HttpHeaders;
        // salespersoncodecaption: Text[1000];

        isWelcomeCompany: Boolean;




    trigger OnOpenPage();
    begin

        isWelcomeCompany := true;

        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')

       then begin
            isWelcomeCompany := false;
            Caption := Caption('Patients');

        end;


    end;

}


pageextension 50149 CustomContactCard extends "Contact Card"
{
    Caption = 'Patient Card';

    layout
    {
        modify("Foreign Trade")
        {
            Visible = isStaging;
        }

        modify("Profile Questionnaire")
        {
            Visible = isStaging;
        }
        modify("Salesperson Code")
        {
            Caption = 'Agent Code';
            ApplicationArea = Basic, Suite;


        }
        modify(Name)

        {
            Visible = iswelcomecompany;
        }
        modify("Phone No.")

        {
            Visible = iswelcomecompany;
        }

        addafter(Name)
        {
            field("Patient Name"; Rec.Name)
            {
                Caption = 'Patient Name';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Cell-Phone"; Rec."Mobile Phone No.")
            {
                Caption = 'Cell-Phone';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Home Phone"; Rec."Phone No.")
            {
                Caption = 'Home Phone';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("DOB"; Rec."Date of Birth")
            {
                Caption = 'DOB';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Last Contact Date"; Rec."Last Contact Date")
            {
                Caption = 'Last Contact Date';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }



        }

        addafter("Profile Questionnaire")
        {
            group(PateintDetails)
            {
                Caption = 'Patient Details';
                field("Patient ID"; Rec."Patient ID")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("ICD 1"; Rec."ICD 1")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }

                field("ICD 2"; Rec."ICD 2")

                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("ICD 3"; Rec."ICD 3")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("CPT 1"; Rec."CPT 1")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("CPT 2"; Rec."CPT 2")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }

                field("CPT 3"; Rec."CPT 3")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Insurance Carrier / Plan Name"; Rec."Insurance Carrier / Plan Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("PC Doctor"; Rec."PC Doctor")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Patient First Name"; Rec."Patient First Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Patient Last Name"; Rec."Patient Last Name")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Sex"; Rec."Sex")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Primary Language"; Rec."Primary Language")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Race / Ethnicity"; Rec."Race / Ethnicity")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Employer"; Rec."Employer")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Emergency Contact"; Rec."Emergency Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Emergency Contact Phone"; Rec."Emergency Contact Phone ")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Reason For Last Visit"; Rec."Reason For Last Visit")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }

                field("Patient Balance"; Rec."Patient Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }

                field("Deductible"; Rec."Deductible")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }
                field("Last Visit Date"; Rec."Last Visit Date")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = NOT iswelcomecompany;
                }


            }
        }

    }

    var
        salespersoncodecaption: Text[1000];

        isWelcomeCompany: Boolean;
        isStaging: Boolean;

    trigger OnOpenPage();
    begin

        isWelcomeCompany := true;
        isStaging := true;

        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')

        then begin
            isWelcomeCompany := false;
            Caption := Caption('Patient Card');

        end;
        if (CompanyName() = 'Staging Welcome Center')

              then begin
            isStaging := false;


        end;
    end;


}


pageextension 50112 SegmentList extends "Segment List"
{
    AdditionalSearchTerms = 'Segment,Work File';
    Caption = 'Work Files';
    // DataCaptionExpression = 'Work File';
    // Description = 'Work File';
    // InstructionalText = 'Work File';
    // AboutTitle = 'Work File';
    // AboutText = 'Work File';

    layout
    {
        modify("Salesperson Code")
        {
            Visible = isWelcomeCompany;
        }
        addafter("Salesperson Code")
        {
            field("Agent Code"; Rec."Salesperson Code")
            {
                Caption = 'Agent Code';
                ApplicationArea = Basic, Suite;
                Visible = Not isWelcomeCompany;

            }
        }
    }


    var
        isWelcomeCompany: Boolean;

    trigger OnOpenPage()

    begin


        isWelcomeCompany := true;
        Caption := Caption('Segments');
        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')
  then begin
            isWelcomeCompany := false;
            Caption := Caption('Work Files');
        end;

    end;




}

page 50115 "SMS Data"
{
    AutoSplitKey = true;

    DelayedInsert = true;
    PageType = Worksheet;

    PromotedActionCategories = 'New,Process,Line';
    SaveValues = true;

    UsageCategory = Tasks;

    ApplicationArea = All;

    Caption = 'SMS Data';
    SourceTable = SMSDataTable;

    AdditionalSearchTerms = 'SMS Data';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;

                }
                field("Contact No."; Rec.ContactNo)
                {
                    ApplicationArea = All;

                }
                field("Mobile No."; Rec.MobileNo)
                {
                    ApplicationArea = All;

                }

                field(SegmentNo; Rec.SegmentNo)
                {
                    ApplicationArea = All;

                }

                field(TextMessage; Rec.TextMessage)
                {
                    ApplicationArea = All;

                }
                field(isSent; Rec.isSent)
                {
                    ApplicationArea = All;

                }




            }
        }
    }


}
pageextension 50113 SegmentCard extends Segment
{
    AdditionalSearchTerms = 'Segment,Work File';
    Caption = 'Segments';

    //  Description = ' Work Files';
    // InstructionalText = ' Work Files';
    //AboutTitle = ' Work Files';
    //AboutText = ' Work Files';

    layout
    {
        modify("Salesperson Code")
        {
            Visible = isWelcomeCompany;
        }
        addafter("Salesperson Code")
        {
            field("Agent Code"; Rec."Salesperson Code")
            {
                Caption = 'Agent Code';
                Visible = Not isWelcomeCompany;
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        addafter(Contacts)
        {
            action(AddContact)
            {
                ApplicationArea = RelationshipMgmt;
                Caption = 'Add Patient';
                Ellipsis = true;
                Image = AddContacts;
                Visible = not isWelcomeCompany;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Select which contacts to add to the segment.';

                trigger OnAction()
                var
                    SegHeader: Record "Segment Header";
                begin
                    SegHeader := Rec;
                    SegHeader.SetRecFilter;
                    REPORT.RunModal(REPORT::"Add Contacts", true, false, SegHeader);
                end;
            }
            action(SendMessage)
            {
                ApplicationArea = RelationshipMgmt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = NOT isWelcomeCompany;
                AccessByPermission = TableData Attachment = R;
                Caption = 'Send Message';
                Image = SendMail;
                Scope = Repeater;
                ToolTip = 'Send message to selected contact.';

                trigger OnAction()

                var
                    segmentline: Record "Segment Line";
                    SMSData: Record SMSDataTable;
                    ContactTbl: Record Contact;
                    SMSID: integer;
                begin
                    SMSData.DeleteAll();
                    SMSID := 0;
                    // segmentline.SetFilter("Segment No.", rec."No.");
                    segmentline.SetFilter("Interaction Template Code", 'SMS');
                    if segmentline.FindSet()
                    then
                        repeat
                            ContactTbl.SetFilter("No.", segmentline."Contact No.");
                            if ContactTbl.FindFirst()
                            then begin



                                if (ContactTbl."Mobile Phone No." <> '')
                                then begin
                                    if (SMSID <> 0) then begin

                                        SMSData.ID := SMSID + 1;
                                    end;
                                    SMSData.ContactNo := ContactTbl."No.";
                                    SMSData.MobileNo := ContactTbl."Mobile Phone No.";
                                    SMSData.isSent := false;
                                    SMSData.SegmentNo := Rec."No.";
                                    SMSData.TextMessage := '';


                                    if SMSData.Insert() then begin
                                        SMSID := SMSData.ID;

                                    end;
                                    Commit();
                                end;

                            end;
                        until segmentline.Next() = 0;

                    //CurrPage.SetSelectionFilter(Contacts);

                    if (SMSData.Count > 0) then begin


                        REPORT.RunModal(REPORT::"Send Bulk SMS", true, true, SMSData);
                    end
                    else begin


                        message('Contacts  for messages doesnot exist!');
                    end;



                end;

                //     CLEAR(Mywindow);
                //     Mywindow.OPEN('Input your nickname: #1#########');
                //     mywindow.INPUT(1, myinputtext);
                //     mywindow.CLOSE;
                //     MESSAGE('Hello, %1', myinputtext);

                // end;


            }
            action(Call)
            {
                ApplicationArea = RelationshipMgmt;


                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = NOT isWelcomeCompany;
                AccessByPermission = TableData Attachment = R;
                Caption = 'Make call';
                Image = Calls;
                Scope = Repeater;
                ToolTip = 'Call to selected contact.';

                trigger OnAction()
                var
                    segmentline: Record "Segment Line";
                    SMSData: Record SMSDataTable;
                    ContactTbl: Record Contact;
                    SMSID: integer;
                begin
                    segmentline.SetFilter("Interaction Template Code", 'OUTGOING');
                    segmentline.SetFilter("Segment No.", Rec."No.");


                    if segmentline.FindSet()
                        then
                        repeat


                            CreatePhoneCall(segmentline."Segment No.");

                        until segmentline.Next() = 0;


                end;
                // trigger OnAction()

                // var
                //     segmentline: Record "Segment Line";
                //     SMSData: Record SMSDataTable;
                //     ContactTbl: Record Contact;
                //     SMSID: integer;
                // begin
                //     SMSData.DeleteAll();
                //     SMSID := 0;
                //     // segmentline.SetFilter("Segment No.", rec."No.");
                //     segmentline.SetFilter("Interaction Template Code", 'SMS');
                //     if segmentline.FindSet()
                //     then
                //         repeat
                //             ContactTbl.SetFilter("No.", segmentline."Contact No.");
                //             if ContactTbl.FindFirst()
                //             then begin



                //                 if (ContactTbl."Mobile Phone No." <> '')
                //                 then begin
                //                     if (SMSID <> 0) then begin

                //                         SMSData.ID := SMSID + 1;
                //                     end;
                //                     SMSData.ContactNo := ContactTbl."No.";
                //                     SMSData.MobileNo := ContactTbl."Mobile Phone No.";
                //                     SMSData.isSent := false;
                //                     SMSData.SegmentNo := Rec."No.";
                //                     SMSData.TextMessage := '';


                //                     if SMSData.Insert() then begin
                //                         SMSID := SMSData.ID;

                //                     end;
                //                     Commit();
                //                 end;

                //             end;
                //         until segmentline.Next() = 0;

                //     //CurrPage.SetSelectionFilter(Contacts);

                //     if (SMSData.Count > 0) then begin


                //         REPORT.RunModal(REPORT::"Send Bulk SMS", true, true, SMSData);
                //     end
                //     else begin


                //         message('Contacts  for messages doesnot exist!');
                //     end;



                // end;

                //     CLEAR(Mywindow);
                //     Mywindow.OPEN('Input your nickname: #1#########');
                //     mywindow.INPUT(1, myinputtext);
                //     mywindow.CLOSE;
                //     MESSAGE('Hello, %1', myinputtext);

                // end;


            }
            action(BulkCall)
            {
                ApplicationArea = RelationshipMgmt;


                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = NOT isWelcomeCompany;
                AccessByPermission = TableData Attachment = R;
                Caption = 'Make Bulk call';
                Image = Calls;
                Scope = Repeater;
                ToolTip = 'Call to selected contact.';

                trigger OnAction()
                var
                    segmentline: Record "Segment Line";
                    SMSData: Record SMSDataTable;
                    ContactTbl: Record Contact;
                    SMSID: integer;
                begin
                    segmentline.SetFilter("Interaction Template Code", 'OUTGOING');
                    segmentline.SetFilter("Segment No.", Rec."No.");


                    if segmentline.FindSet()
                        then
                        repeat

                            Message('Entered in hyperlink');
                            HyperLink(StrSubstNo('tel:%1', segmentline."Contact Phone No."));
                            if Confirm('Do you want to move on next call?', false) then
                                break;






                        //   CreatePhoneCall(segmentline."Segment No.");

                        until segmentline.Next() = 0;


                end;
                // trigger OnAction()

                // var
                //     segmentline: Record "Segment Line";
                //     SMSData: Record SMSDataTable;
                //     ContactTbl: Record Contact;
                //     SMSID: integer;
                // begin
                //     SMSData.DeleteAll();
                //     SMSID := 0;
                //     // segmentline.SetFilter("Segment No.", rec."No.");
                //     segmentline.SetFilter("Interaction Template Code", 'SMS');
                //     if segmentline.FindSet()
                //     then
                //         repeat
                //             ContactTbl.SetFilter("No.", segmentline."Contact No.");
                //             if ContactTbl.FindFirst()
                //             then begin



                //                 if (ContactTbl."Mobile Phone No." <> '')
                //                 then begin
                //                     if (SMSID <> 0) then begin

                //                         SMSData.ID := SMSID + 1;
                //                     end;
                //                     SMSData.ContactNo := ContactTbl."No.";
                //                     SMSData.MobileNo := ContactTbl."Mobile Phone No.";
                //                     SMSData.isSent := false;
                //                     SMSData.SegmentNo := Rec."No.";
                //                     SMSData.TextMessage := '';


                //                     if SMSData.Insert() then begin
                //                         SMSID := SMSData.ID;

                //                     end;
                //                     Commit();
                //                 end;

                //             end;
                //         until segmentline.Next() = 0;

                //     //CurrPage.SetSelectionFilter(Contacts);

                //     if (SMSData.Count > 0) then begin


                //         REPORT.RunModal(REPORT::"Send Bulk SMS", true, true, SMSData);
                //     end
                //     else begin


                //         message('Contacts  for messages doesnot exist!');
                //     end;



                // end;

                //     CLEAR(Mywindow);
                //     Mywindow.OPEN('Input your nickname: #1#########');
                //     mywindow.INPUT(1, myinputtext);
                //     mywindow.CLOSE;
                //     MESSAGE('Hello, %1', myinputtext);

                // end;


            }

        }
        modify(Contacts)
        {
            Visible = isWelcomeCompany;
        }
        modify(AddContacts)
        {
            Visible = isWelcomeCompany;
        }
        modify("&Print")
        {
            Visible = isWelcomeCompany;
        }
        modify(Action60)
        {
            Visible = isWelcomeCompany;
        }
        modify("Apply &Mailing Group")
        {
            Visible = isWelcomeCompany;
        }
        modify(CoverSheet)
        {
            Visible = isWelcomeCompany;
        }
        modify("Create opportunities")
        {
            Visible = isWelcomeCompany;
        }
        modify("Create opportunity")
        {
            Visible = isWelcomeCompany;
        }
        modify(Criteria)
        {
            Visible = isWelcomeCompany;
        }
        modify(Export)
        {
            Visible = isWelcomeCompany;
        }
        modify("F&unctions")
        {
            Visible = isWelcomeCompany;
        }
        modify("Go Back")
        {
            Visible = isWelcomeCompany;
        }
        modify(Import)
        {
            Visible = isWelcomeCompany;
        }
        modify(ExportContacts)
        {
            Visible = isWelcomeCompany;
        }
        modify("Reuse Segment")
        {
            Visible = isWelcomeCompany;
        }
        modify("S&egment")
        {
            Visible = isWelcomeCompany;
        }
        modify("T&asks")
        {
            Visible = isWelcomeCompany;
        }
        modify(SaveCriteria)
        {
            Visible = isWelcomeCompany;
        }
        modify(ReuseCriteria)
        {
            Visible = isWelcomeCompany;
        }
        modify(ReduceContacts)
        {
            Visible = isWelcomeCompany;
        }


    }


    var
        isWelcomeCompany: Boolean;
        cap: Text;

    trigger OnOpenPage()

    begin


        isWelcomeCompany := true;
        //cap := Caption('Segments');
        Caption := Caption('Segments');
        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')
        then begin
            isWelcomeCompany := false;
            //  cap := Caption('Work File');
            Caption := Caption('Work File');
        end;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreatePhoneCall(var SegmentLine: Record "Segment Line"; var IsHandled: Boolean)
    begin
    end;

    procedure CreatePhoneCall(Segmentno: Text)
    var
        TempSegmentLine: Record "Segment Line" temporary;
        IsHandled: Boolean;
        //Rec: Record "Segment Header";
        Cont: Record Contact;
        Segment: Record "Segment Line";
        Compaign: Record "Segment Header";
        compaignno: code[20];
    begin

        Segment.SetFilter("Segment No.", Segmentno);
        if Segment.FindFirst() then begin


            compaignno := Segment."Campaign No.";




            IsHandled := false;
            OnBeforeCreatePhoneCall(Segment, IsHandled);
            if IsHandled then
                exit;

            Cont.Get(Segment."Contact No.");
            TempSegmentLine."Contact No." := Cont."No.";
            TempSegmentLine."Contact Via" := Cont."Phone No.";
            //TempSegmentLine."Contact Via" := Cont."Phone No.";
            TempSegmentLine."Contact Company No." := Cont."Company No.";
            TempSegmentLine."To-do No." := Segment."To-do No.";
            TempSegmentLine."Salesperson Code" := Segment."Salesperson Code";

            if Segment."Campaign No." <> '' then
                TempSegmentLine."Campaign No." := Segment."Campaign No.";

            TempSegmentLine."Campaign Target" := Segment."Campaign Target";
            TempSegmentLine."Campaign Response" := Segment."Campaign Response";
            TempSegmentLine.SetRange("Contact No.", TempSegmentLine."Contact No.");
            TempSegmentLine.SetRange("Campaign No.", TempSegmentLine."Campaign No.");

            TempSegmentLine.StartWizard2;
        end;

    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCheckStatus(var SegmentLine: Record "Segment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyFromInteractionLogEntry(var SegmentLine: Record "Segment Line"; InteractionLogEntry: Record "Interaction Log Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreateFromTask(var SegmentLine: Record "Segment Line"; Task: Record "To-do")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInitLine(var SegmentLine: Record "Segment Line"; SegmentHeader: Record "Segment Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterFinishWizard(var SegmentLine: Record "Segment Line"; InteractionLogEntry: Record "Interaction Log Entry"; IsFinish: Boolean; Flag: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCheckStatus(var SegmentLine: Record "Segment Line"; var IsHandled: Boolean)
    begin
    end;



    [IntegrationEvent(false, false)]
    local procedure OnBeforeSendCreateOpportunityNotification(var SegmentLine: Record "Segment Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetCorrespondenceType(var SegmentLine: Record "Segment Line"; var xSegmentLine: Record "Segment Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStartWizard(var SegmentLine: Record "Segment Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeStartWizard2(var SegmentLine: Record "Segment Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateInteractionFromContactOnBeforeStartWizard(var SegmentLine: Record "Segment Line"; var Contact: Record Contact)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateInteractionFromSalespersonOnBeforeStartWizard(var SegmentLine: Record "Segment Line"; SalespersonPurchaser: Record "Salesperson/Purchaser")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateInteractionFromInteractLogEntryOnBeforeStartWizard(var SegmentLine: Record "Segment Line"; var InteractionLogEntry: Record "Interaction Log Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateInteractionFromTaskOnBeforeStartWizard(var SegmentLine: Record "Segment Line"; Task: Record "To-do")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreateInteractionFromOppOnBeforeStartWizard(var SegmentLine: Record "Segment Line"; Opportunity: Record Opportunity)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFinishWizardOnAfterSetSend(var SegmentLine: Record "Segment Line"; var Send: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnHandleTriggerCaseElse(SegmentLine: Record "Segment Line"; InteractionTemplate: Record "Interaction Template")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnValidateInteractionTemplateCode(var SegmentLine: Record "Segment Line"; var Cont: Record Contact; var IsHandled: Boolean)
    begin
    end;
}

tableextension 50114 segmentHeader extends "Segment Header"
{
    fields
    {
        field(50001; "Last Contact Date"; Date)
        {

            AutoFormatType = 1;
            CalcFormula = max(Contact."Last Contact Date" where("No." = field("No.")));
            Caption = 'Last Contact Date';
            FieldClass = FlowField;
        }

        field(50002; "Last Visit Date"; Date)
        {

            // AutoFormatType = 1;
            // CalcFormula = max("Interaction Log Entry".Date where("Contact Name" = field(Name)));
            Caption = 'Last Visit Date';
            Editable = false;
            Enabled = false;
            //  FieldClass = FlowField;
        }

    }


}

pageextension 50115 segmentSubForm extends "Segment Subform"
{
    layout
    {
        modify("Contact Mobile Phone No.")
        {
            Visible = iswelcomecompany;
        }
        modify("Contact Phone No.")
        {
            Visible = iswelcomecompany;
        }
        modify("Contact E-Mail")
        {
            Visible = iswelcomecompany;
        }

        addafter("Contact E-Mail")
        {
            field("Phone Number"; rec."Contact Phone No.")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
                ToolTip = 'Patient Phone Number';
            }
            field("Mobile Phone Number"; Rec."Contact Mobile Phone No.")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
                ToolTip = 'Patient Mobile Number';
            }
            field("Email"; Rec."Contact Email")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
                ToolTip = 'Patient Email Address';
            }



            field("Patient ID"; Rec."Patient ID")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("ICD 1"; Rec."ICD 1")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("ICD 2"; Rec."ICD 2")

            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("ICD 3"; Rec."ICD 3")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("CPT 1"; Rec."CPT 1")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("CPT 2"; Rec."CPT 2")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("CPT 3"; Rec."CPT 3")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Insurance Carrier / Plan Name"; Rec."Insurance Carrier / Plan Name")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("PC Doctor"; Rec."PC Doctor")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Patient First Name"; Rec."Patient First Name")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Patient Last Name"; Rec."Patient Last Name")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Sex"; Rec."Sex")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Marital Status"; Rec."Marital Status")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Primary Language"; Rec."Primary Language")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Race / Ethnicity"; Rec."Race / Ethnicity")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Employer"; Rec."Employer")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Emergency Contact"; Rec."Emergency Contact")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Emergency Contact Phone"; Rec."Emergency Contact Phone ")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Reason For Last Visit"; Rec."Reason For Last Visit")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("Patient Balance"; Rec."Patient Balance")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }

            field("Deductible"; Rec."Deductible")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Date of Birth"; Rec."Date of Birth")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Last Visit Date"; Rec."Last Visit Date")
            {
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Agent Code"; Rec."Salesperson Code")
            {
                Caption = 'Agent Code';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Patient Name"; Rec."Contact Name")
            {
                Caption = 'Patient Name';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            field("Disposition Code"; Rec."Disposition Code New")
            {
                Caption = 'Disposition Code';
                ApplicationArea = Basic, Suite;
                Visible = NOT iswelcomecompany;
            }
            // field("Disposition Name"; Rec."Disposition Name")
            // {
            //     Caption = 'Disposition';
            //     ApplicationArea = Basic, Suite;
            //     Visible = NOT iswelcomecompany;
            // }


        }
        modify("Salesperson Code")
        {
            Visible = isWelcomeCompany;


        }
        modify("Contact Name")

        {
            Visible = isWelcomeCompany;
        }
    }
    actions
    {
        addafter(Line)
        {

        }
    }

    var
        isWelcomeCompany: Boolean;

    trigger OnOpenPage()

    begin


        isWelcomeCompany := true;
        // Caption := Caption('Segments');
        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')
       then begin
            isWelcomeCompany := false;
            //   Caption := Caption('Work File');
        end;

    end;
}

reportextension 50116 RptExtension extends "Add Contacts"
{
    dataset
    {
        modify(Contact)
        {
            RequestFilterFields = "No.", "Search Name", Type, "Last Visit Date", "Patient ID";
        }
    }
}

table 50137 "Disposition Code"
{
    fields
    {

        field(50002; "Code"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Disposition Code';

        }
        field(50003; "Disposotion Name"; Text[2000])
        {
            Caption = ' Name';
        }

    }
    keys
    {
        key(PrimaryKey; "Disposotion Name", "Code")
        {
            Clustered = true;
        }

    }

}

page 50138 "Disposition Code"
{
    AutoSplitKey = true;

    DelayedInsert = true;
    PageType = Worksheet;

    PromotedActionCategories = 'New,Process,Line';
    SaveValues = true;

    UsageCategory = Tasks;

    ApplicationArea = All;

    Caption = 'Disposition Code';
    SourceTable = "Disposition Code";

    AdditionalSearchTerms = 'Disposition Code';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the disposition code';
                }
                field("Disposotion Name"; Rec."Disposotion Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specify the disposition name';
                }



            }
        }
    }


}

pageextension 50139 LoggedSegmentex extends "Logged Segments"
{

    //Caption = 'Logged Work Files';
    //DataCaptionExpression = 'Logged Work Files';
    // Description = 'Logged Work Files';
    // InstructionalText = 'Logged Work Files';
    // AboutTitle = 'Logged Work Files';
    // AboutText = 'Logged Work Files';
    AdditionalSearchTerms = 'Logged Work Files,Logged Segment, Segment, WorkFile';

    var
        isWelcomeCompany: Boolean;

    trigger OnOpenPage()

    begin


        isWelcomeCompany := true;
        Caption := Caption('Logged Segments');
        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')
       then begin
            isWelcomeCompany := false;
            Caption := Caption('Logged Work Files');
        end;

    end;

}

pageextension 50140 SalePersonCodeEx extends "Salespersons/Purchasers"
{
    // DataCaptionExpression = 'Agents';
    // Description = 'Agents';
    // InstructionalText = 'Agents';
    //AboutTitle = 'Agents / Salesperson';

    //AboutText = 'Agents / Salesperson';
    AdditionalSearchTerms = 'Agents, SalesPerson';
    //Caption = 'Agents / Salesperson';
    actions
    {
        modify("&Salesperson")
        {

            Caption = 'Agent';
        }
    }
    var
        isWelcomeCompany: Boolean;
        cap: Text;

    trigger OnOpenPage()

    begin


        isWelcomeCompany := true;
        Caption := Caption('Salesperson');
        // cap := Caption('Salesperson');
        if (CompanyName() = 'Welcome Center') OR (CompanyName() = 'Staging Welcome Center')
       then begin
            isWelcomeCompany := false;
            Caption := Caption('Agents');
            //    cap := Caption('Agents');
        end;

    end;

}


TABLE 50111 SMSDialougeWindow
{
    Caption = 'SMS Text';
    fields
    {
        field(50101; ID; Integer)
        {
            Caption = 'Contact';
            AutoFormatType = 1;
            AutoIncrement = true;
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50100; ContactNo; Code[20])
        {
            Caption = 'Contact';

            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50102; MobileNo; Text[50])
        {
            Caption = 'Cell No.';
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50103; TextMessage; text[2048])
        {
            Caption = 'Text';
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50104; isSent; Boolean)
        {
            Caption = 'Is Sent';
            InitValue = false;
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
    }

}
TABLE 50112 SMSDataTable
{
    Caption = 'SMS Text';
    fields
    {
        field(50100; ID; Integer)
        {
            Caption = 'ID';
            AutoFormatType = 1;
            AutoIncrement = true;
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50101; ContactNo; Code[20])
        {
            Caption = 'Contact';

            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50102; MobileNo; Text[50])
        {
            Caption = 'Cell No.';
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50103; TextMessage; text[2048])
        {
            Caption = 'Text';
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50104; isSent; Boolean)
        {
            Caption = 'Is Sent';
            InitValue = false;
            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
        field(50105; SegmentNo; Code[20])
        {
            Caption = 'Segment No.';

            //    AutoFormatType = 1;
            //     CalcFormula =lookup(Contact."No.");
            //     Caption = 'Contact No';
            //     FieldClass = FlowField;
        }
    }
    keys
    {
        key(PrimaryKey; ID)
        {

        }

    }
}

table 50117 TextmessageTemplate
{
    Caption = 'SMS templates';
    fields
    {
        field(50101; "ID"; integer)
        {
            AutoIncrement = true;
        }
        field(50102; "SMS Template"; Text[2048])
        {

        }
    }
}




page 50118 Textmessagetemplates
{
    caption = 'SMS Templates';
    AutoSplitKey = true;

    DelayedInsert = true;
    PageType = Worksheet;

    // PromotedActionCategories = 'New,Process,Line';
    SaveValues = true;

    UsageCategory = Tasks;

    ApplicationArea = All;


    SourceTable = TextmessageTemplate;

    AdditionalSearchTerms = 'SMS Template,SMS,Template,Message, Message Templates';

    Layout
    {

        area(content)
        {
            repeater(General)
            {
                field("SMS Template"; Rec."SMS Template")
                {
                    caption = 'SMS Template(s)';
                    ApplicationArea = ALL;

                }

            }
        }
    }
}

report 50114 "Send Bulk SMS"
{
    Caption = 'Send SMS';
    ProcessingOnly = true;
    UseRequestPage = true;



    dataset
    {
        dataitem(SourceSms; SMSDataTable)
        {
            DataItemTableView = sorting(ID) order(descending);

            trigger OnAfterGetRecord()
            var
                SMSData: Record SMSDataTable;

            begin

                SMSData.SetFilter(isSent, '%1', SourceSms.isSent);
                SMSData.SetFilter(SegmentNo, SourceSms.SegmentNo);
                if SMSData.FindSet()
                then
                    repeat
                        if (TextMessage = '') then begin
                            SMSData.TextMessage := TextMessageNew;
                        end else begin
                            SMSData.TextMessage := TextMessage;
                        end;
                        SMSData.Modify();
                    until SMSData.Next() = 0

            end;

        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                group(Options)
                {
                    Caption = 'SMS Text';

                    // field(ContactNo; SourceSms.ContactNo)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Contact No.';
                    //     Editable = false;
                    // }

                    // field(Mobile; SourceSms.MobileNo)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Mobile No.';
                    //     Editable = false;
                    // }

                    field(Textmessage; TextMessage)
                    {
                        ApplicationArea = All;
                        Caption = 'SMS Text';
                        Editable = true;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SMSTemplate: Record TextmessageTemplate;
                        begin
                            SMSTemplate.Reset();
                            if Page.RunModal(Page::Textmessagetemplates, SMSTemplate) = Action::LookupOK then
                                TextMessage := SMSTemplate."SMS Template";
                        end;
                    }
                    field(TextmessageNew; TextMessageNew)
                    {
                        ApplicationArea = All;
                        Caption = 'Templates';
                        Editable = true;
                        DrillDown = true;
                        trigger OnDrillDown()
                        var
                            SMSTemplate: Record TextmessageTemplate;
                        begin
                            SMSTemplate.Reset();
                            if Page.RunModal(Page::Textmessagetemplates, SMSTemplate) = Action::LookupOK then
                                TextMessageNew := SMSTemplate."SMS Template";
                        end;
                    }
                }
            }
        }

        actions
        {

        }

    }

    labels
    {
    }


    trigger OnPostReport()
    var
        SentSMSNo: Integer;
        couldnotSentSms: Integer;
        EntryNo: integer;
        confirmation: boolean;
    begin
        SentSMSNo := 0;
        couldnotSentSms := 0;
        if (SmsData.Count > 0) then Begin
            SmsData.SetFilter(SmsData.isSent, '%1', false);


            //  message(format(SmsData.Count));
            if SmsData.FindSet() then
                repeat
                    ApiResult := DialPadSms(SmsData.ContactNo, SmsData.MobileNo, '5095637258797056', SmsData.TextMessage);
                    if (ApiResult = true)
                    then begin

                        SmsData.isSent := true;
                        SmsData.Modify();
                        SentSMSNo := SentSMSNo + 1;

                        VarContact.SetFilter("No.", SmsData.ContactNo);
                        if VarContact.FindFirst()
                        then begin
                            if Interactionlog.FindLast()
                            then begin
                                EntryNo := Interactionlog."Entry No.";
                            end;

                            Interactionlog."Entry No." := EntryNo + 1;
                            Interactionlog."Contact No." := VarContact."No.";
                            Interactionlog.PatientID := VarContact."Patient ID";
                            Interactionlog.Comments := 'SMS';
                            Interactionlog.Date := System.Today();
                            Interactionlog.Comments1 := SmsData.TextMessage;
                            Interactionlog.Description := 'Bulk message(s) sent to ' + VarContact.Name + ' (' + VarContact."Mobile Phone No." + ')';
                            Interactionlog."Contact Name" := VarContact.Name;
                            Interactionlog."Contact Company Name" := VarContact."Company Name";
                            Interactionlog."Contact Via" := VarContact."Mobile Phone No.";
                            Interactionlog.SMSText := SmsData.TextMessage;
                            Interactionlog."Time of Interaction" := system.Time();
                            Interactionlog."Interaction Template Code" := 'SMS';
                            Interactionlog.Insert();
                            commit();
                        end;
                    end else begin
                        couldnotSentSms := couldnotSentSms + 1;

                    end;
                until SmsData.Next() = 0;
            if (SentSMSNo > 0)
            then begin
                if (couldnotSentSms > 0)
                then begin
                    Message(Format(SentSMSNo) + ' messages sent successfully & ' + format(couldnotSentSms) + ' couldnot sent!');
                end else begin
                    Message(Format(SentSMSNo) + ' messages sent successfully');
                end;
            end
            else begin
                if (couldnotSentSms > 0)
                then begin
                    Message(format(couldnotSentSms) + ' messages couldnot sent!');
                end;
            end;


        End;


    end;




    var
        ApiResult: Boolean;
        SmsData: record SMSDataTable;
        Interactionlog: Record "Interaction Log Entry";
        TextMessage: Text;
        TextMessageNew: Text;

        VarContact: Record Contact;


    procedure CreateBasicAuthHeader(UserName: Text;
                     Password:
                         Text):
            Text
    var


#pragma warning disable AL0432
        TempBlob: Record TempBlob;
#pragma warning restore AL0432


    begin
        TempBlob.WriteAsText(StrSubstNo('%1:%2', UserName, Password), TextEncoding::UTF8);
        exit(StrSubstNo('Basic %1', TempBlob.ToBase64String()));
    end;

    procedure DialPadSms(ContactNo: Code[20]; CellNo: Code[30]; UserId: Text; textSMS: Text[2048])
    result: boolean
    Var
        Client: HttpClient;
        RequestHeaders: HttpHeaders;

        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        url: text;
        contentHeaders: HttpHeaders;
        body: Text;
    begin
        RequestHeaders := Client.DefaultRequestHeaders();
        //Message(UserId);
        //url := StrSubstNo('https://api.businesscentral.dynamics.com/v2.0/1a9533fb-c524-4eb7-96c8-fbdc362ac6a0/Sandbox/ODataV4/Company(''%1'')/General_Journals', CompanyName);

        body := '{"to_numbers":["+1' + Delchr(DelChr(CellNo, '=', '-'), '=', ' ') + '"],"text":"' + textSMS + '","user_id":"' + UserId + '"}';
        //body := '{"to_numbers":["+17349450111"],"text":"' + textSMS + '","user_id":"' + UserId + '"}';


        //  Message(body);
        url := StrSubstNo('https://dialpad.com/api/v2/sms?apikey=SUbAMUyuR5S9p4ckyPy3LR4r3EWZgbk5v3nUzEtmJVHVgeJCeZU6WURBrvfTdgdcMRvPVmtvMBcxk8Hz83jD4bG9xzJng6bnAfrg');
        RequestContent.WriteFrom(body);
        Client.Post(url, RequestContent, ResponseMessage);
        ResponseMessage.Content().ReadAs(ResponseText);
        //Message(ResponseText);
        if (ResponseMessage.IsSuccessStatusCode)
          then begin
            result := true;
        end else begin
            result := false;
        end;
    end;

}
report 50113 "Send SMS"
{
    Caption = 'Send SMS';
    ProcessingOnly = true;
    UseRequestPage = true;



    dataset
    {
        dataitem(SourceSms; SMSDataTable)
        {
            DataItemTableView = sorting(ID) order(descending);

            trigger OnAfterGetRecord()
            var
                SMSData: Record SMSDataTable;

            begin

                SMSData.SetFilter(ContactNo, SourceSms.ContactNo);
                SMSData.SetFilter(MobileNo, SourceSms.MobileNo);
                SMSData.SetFilter(isSent, '%1', SourceSms.isSent);
                if SMSData.FindSet()
                then
                    repeat
                        if (TextMessage1 = '') then begin
                            SMSData.TextMessage := TextMessageNew;
                        end else begin
                            SMSData.TextMessage := TextMessage1;
                        end;

                        SMSData.Modify();
                    until SMSData.Next() = 0;
            end;

        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                group(Options)
                {
                    Caption = 'SMS Text';



                    field(Textmessage; TextMessage1)
                    {
                        ApplicationArea = All;
                        Caption = 'SMS Text';
                        Editable = true;
                    }
                    field(TextmessageNew; TextMessageNew)
                    {
                        ApplicationArea = All;
                        Caption = 'Templates';
                        Editable = true;
                        DrillDown = true;
                        trigger OnDrillDown()
                        var
                            SMSTemplate: Record TextmessageTemplate;
                        begin
                            SMSTemplate.Reset();
                            if Page.RunModal(Page::Textmessagetemplates, SMSTemplate) = Action::LookupOK then
                                TextMessageNew := SMSTemplate."SMS Template";
                        end;
                    }
                }
            }
        }

        actions
        {

        }

    }

    labels
    {
    }


    trigger OnPostReport()
    var
        EntryNo: integer;
        sentsmsdetails: Record SentSMSDetails;

    begin
        if (SmsData.Count > 0) then Begin
            SmsData.SetFilter(SmsData.isSent, '%1', false);
            SmsData.SetFilter(SmsData.ContactNo, SourceSms.ContactNo);
            SmsData.SetFilter(SmsData.MobileNo, SourceSms.MobileNo);


            if SmsData.FindSet()
            then
                repeat

                    ApiResult := DialPadSms(SmsData.ContactNo, SmsData.MobileNo, '5095637258797056', SmsData.TextMessage);
                    if (ApiResult = true)
                    then begin
                        Message('SMS sent successfully');

                        SmsData.isSent := true;
                        SmsData.Modify();
                        VarContact.SetFilter("No.", SmsData.ContactNo);
                        if VarContact.FindFirst()
                        then begin
                            if Interactionlog.FindLast()
                                      then begin
                                EntryNo := Interactionlog."Entry No.";
                            end;

                            Interactionlog."Entry No." := EntryNo + 1;
                            Interactionlog."Contact No." := VarContact."No.";
                            Interactionlog.PatientID := VarContact."Patient ID";
                            Interactionlog.Comments := 'SMS';
                            Interactionlog.Comments1 := SmsData.TextMessage;
                            Interactionlog.CallInitationTime := time;
                            Interactionlog.Date := System.Today();
                            Interactionlog."Contact Name" := VarContact.Name;
                            Interactionlog.Description := 'Message sent to ' + VarContact.Name + ' (' + VarContact."Mobile Phone No." + ')';
                            Interactionlog."Contact Company Name" := VarContact."Company Name";
                            Interactionlog."Contact Via" := VarContact."Mobile Phone No.";
                            Interactionlog."Time of Interaction" := System.Time();
                            Interactionlog.SMSText := SmsData.TextMessage;
                            Interactionlog."Interaction Template Code" := 'SMS';
                            Interactionlog.Insert();
                            commit();
                            sentsmsdetails."Date and Time" := System.CurrentDateTime;
                            sentsmsdetails.EntryNo := EntryNo;
                            sentsmsdetails."Sent By User Id" := UserId;
                            sentsmsdetails."Sent By Agent Code" := Interactionlog."Salesperson Code";
                            sentsmsdetails."Sent To Number" := VarContact."Mobile Phone No.";
                            sentsmsdetails."Sent To Patient" := VarContact.Name;
                            sentsmsdetails."SMS Text" := SmsData.TextMessage;
                            sentsmsdetails.Insert();
                            Commit();
                        end;
                    end else begin
                        Message('There is some error!');
                    end;
                until SmsData.Next() = 0;
        End;
    end;




    var
        ApiResult: Boolean;
        SmsData: record SMSDataTable;
        Interactionlog: Record "Interaction Log Entry";

        MessageTemplate: Record TextmessageTemplate;
        TextMessage1: Text;
        TextMessageNew: text;
        ContactNo: Code[20];
        MobileNo: Text[50];

        VarContact: Record Contact;
        result: list of [Text];
        Client: HttpClient;
        RequestHeaders: HttpHeaders;
        body: Text;
        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        url: text;
        contentHeaders: HttpHeaders;


    procedure CreateBasicAuthHeader(UserName: Text;
                     Password:
                         Text):
            Text
    var

#pragma warning disable AL0432
        TempBlob: Record TempBlob;
#pragma warning restore AL0432

    begin
        TempBlob.WriteAsText(StrSubstNo('%1:%2', UserName, Password), TextEncoding::UTF8);
        exit(StrSubstNo('Basic %1', TempBlob.ToBase64String()));
    end;

    procedure DialPadSms(ContactNo: Code[20]; CellNo: Code[30]; UserId: Text; textSMS: Text[2048])
    result: boolean
    Var
        Client: HttpClient;
        RequestHeaders: HttpHeaders;

        RequestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        ResponseText: Text;
        url: text;
        contentHeaders: HttpHeaders;
        body: Text;
    begin
        RequestHeaders := Client.DefaultRequestHeaders();
        //Message(UserId);
        //url := StrSubstNo('https://api.businesscentral.dynamics.com/v2.0/1a9533fb-c524-4eb7-96c8-fbdc362ac6a0/Sandbox/ODataV4/Company(''%1'')/General_Journals', CompanyName);
        body := '{"to_numbers":["+1' + Delchr(DelChr(CellNo, '=', '-'), '=', ' ') + '"],"text":"' + textSMS + '","user_id":"' + UserId + '"}';
        //body := '{"to_numbers":["+17349450111"],"text":"' + textSMS + '","user_id":"' + UserId + '"}';



        //  Message(body);
        url := StrSubstNo('https://dialpad.com/api/v2/sms?apikey=SUbAMUyuR5S9p4ckyPy3LR4r3EWZgbk5v3nUzEtmJVHVgeJCeZU6WURBrvfTdgdcMRvPVmtvMBcxk8Hz83jD4bG9xzJng6bnAfrg');
        RequestContent.WriteFrom(body);
        Client.Post(url, RequestContent, ResponseMessage);
        ResponseMessage.Content().ReadAs(ResponseText);
        //Message(ResponseText);
        if (ResponseMessage.IsSuccessStatusCode)
          then begin
            result := true;
        end else begin
            result := false;
        end;
    end;





}

table 50119 SentSMSDetails
{
    caption = 'Sent Messages';
    fields
    {


        field(50101; "SmsId"; Integer)
        {
            AutoIncrement = true;

        }
        field(50102; "Date and Time"; Datetime)
        {

        }
        field(50103; "Sent By User Id"; Text[100])
        {

        }
        field(50104; "Sent By Agent Code"; Text[100])
        {

        }
        field(50105; "Sent To Patient"; Text[100])
        {

        }
        field(50106; "Sent To Number"; Text[100])
        {

        }
        field(50107; "SMS Text"; Text[2048])
        {

        }
        field(50108; "EntryNo"; Integer)
        {

        }

    }

}
// page 50120 SendMessageDetails
// {
//     Editable = false;

//     Caption = 'Sent Messages';
//     AutoSplitKey = true;

//     DelayedInsert = true;
//     PageType = Worksheet;

//     PromotedActionCategories = 'New,Process,Line';
//     SaveValues = true;

//     UsageCategory = Tasks;

//     ApplicationArea = All;

//     SourceTable = SentSMSDetails;

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 Editable = false;
//                 field(EntryNo; Rec.EntryNo)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Entry No.';

//                 }
//                 field("Date and Time"; Rec."Date and Time")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Date & Time';

//                 }

//                 field("Sent By Agent Code"; Rec."Sent By Agent Code")
//                 {
//                     ApplicationArea = All;

//                 }

//                 field("Sent By User Id"; Rec."Sent By User Id")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Sent To Number"; Rec."Sent To Number")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("Sent To Patient"; Rec."Sent To Patient")
//                 {
//                     ApplicationArea = All;

//                 }
//                 field("SMS Text"; Rec."SMS Text")
//                 {
//                     ApplicationArea = All;

//                 }





//             }
//         }
//     }
// }