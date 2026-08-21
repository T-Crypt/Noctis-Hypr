pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.config
import qs.components
import qs.services

ColumnLayout {
    id: root

    required property string currentCategory
    required property var categories // [{ id, icon, label, description }]

    signal categorySelected(id: string)

    readonly property var filteredCategories: {
        const q = searchInput.text.trim().toLowerCase();
        return q.length === 0 ? root.categories : root.categories.filter(c => c.label.toLowerCase().includes(q) || (c.description ?? "").toLowerCase().includes(q));
    }

    spacing: Tokens.spacing.medium

    StyledRect {
        Layout.fillWidth: true
        Layout.preferredHeight: 36
        radius: Tokens.rounding.full
        color: Colours.layer(Colours.tPalette.m3surfaceContainer, 2)

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: Tokens.padding.medium
            anchors.rightMargin: Tokens.padding.medium
            spacing: Tokens.spacing.small

            MaterialIcon {
                text: "search"
                color: Colours.palette.m3onSurfaceVariant
                fontStyle: Tokens.font.icon.small
            }

            TextInput {
                id: searchInput

                Layout.fillWidth: true
                clip: true
                font: Tokens.font.body.small
                color: Colours.palette.m3onSurface

                Keys.onEscapePressed: searchInput.text = ""

                StyledText {
                    visible: searchInput.text.length === 0
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Search settings…")
                    color: Colours.palette.m3onSurfaceVariant
                    font: Tokens.font.body.small
                }
            }
        }
    }

    ColumnLayout {
        id: list

        Layout.fillWidth: true
        Layout.fillHeight: true
        spacing: 0

        Repeater {
            model: ScriptModel {
                values: root.filteredCategories
            }

            StyledRect {
                id: categoryButton

                required property var modelData
                required property int index

                readonly property bool active: categoryButton.modelData.id === root.currentCategory
                readonly property bool isFirst: categoryButton.index === 0
                readonly property bool isLast: categoryButton.index === root.filteredCategories.length - 1

                Layout.fillWidth: true
                implicitHeight: rowContent.implicitHeight + Tokens.padding.medium * 2

                color: categoryButton.active ? Colours.palette.m3secondaryContainer : Colours.layer(Colours.tPalette.m3surfaceContainer, 2)

                topLeftRadius: stateLayer.pressed ? Tokens.rounding.medium : categoryButton.active ? Tokens.rounding.extraLargeIncreased : categoryButton.isFirst ? Tokens.rounding.extraLarge : Tokens.rounding.extraSmall
                topRightRadius: stateLayer.pressed ? Tokens.rounding.medium : categoryButton.active ? Tokens.rounding.extraLargeIncreased : categoryButton.isFirst ? Tokens.rounding.extraLarge : Tokens.rounding.extraSmall
                bottomLeftRadius: stateLayer.pressed ? Tokens.rounding.medium : categoryButton.active ? Tokens.rounding.extraLargeIncreased : categoryButton.isLast ? Tokens.rounding.extraLarge : Tokens.rounding.extraSmall
                bottomRightRadius: stateLayer.pressed ? Tokens.rounding.medium : categoryButton.active ? Tokens.rounding.extraLargeIncreased : categoryButton.isLast ? Tokens.rounding.extraLarge : Tokens.rounding.extraSmall

                Behavior on color {
                    CAnim {}
                }
                Behavior on topLeftRadius {
                    Anim { type: Anim.DefaultEffects }
                }
                Behavior on topRightRadius {
                    Anim { type: Anim.DefaultEffects }
                }
                Behavior on bottomLeftRadius {
                    Anim { type: Anim.DefaultEffects }
                }
                Behavior on bottomRightRadius {
                    Anim { type: Anim.DefaultEffects }
                }

                RowLayout {
                    id: rowContent

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.margins: Tokens.padding.large
                    spacing: Tokens.spacing.medium

                    StyledRect {
                        Layout.fillHeight: true
                        Layout.topMargin: -1
                        Layout.bottomMargin: -1
                        implicitWidth: height
                        radius: Tokens.rounding.full
                        color: categoryButton.active ? Colours.palette.m3primary : Colours.palette.m3secondaryContainer

                        Behavior on color {
                            CAnim {}
                        }

                        MaterialIcon {
                            anchors.centerIn: parent
                            text: categoryButton.modelData.icon
                            color: categoryButton.active ? Colours.contrastOn(Colours.palette.m3primary) : Colours.palette.m3onSecondaryContainer
                            fontStyle: Tokens.font.icon.builders.medium.weight(Font.Medium).build()
                            fill: categoryButton.active ? 1 : 0
                        }
                    }

                    ColumnLayout {
                        Layout.fillWidth: true
                        spacing: 0

                        StyledText {
                            Layout.fillWidth: true
                            text: categoryButton.modelData.label
                            font: Tokens.font.body.medium
                            elide: Text.ElideRight
                        }

                        StyledText {
                            Layout.fillWidth: true
                            visible: (categoryButton.modelData.description ?? "").length > 0
                            text: categoryButton.modelData.description ?? ""
                            color: Colours.palette.m3onSurfaceVariant
                            font: Tokens.font.label.small
                            elide: Text.ElideRight
                        }
                    }
                }

                StateLayer {
                    id: stateLayer

                    anchors.fill: parent
                    topLeftRadius: categoryButton.topLeftRadius
                    topRightRadius: categoryButton.topRightRadius
                    bottomLeftRadius: categoryButton.bottomLeftRadius
                    bottomRightRadius: categoryButton.bottomRightRadius
                    showHoverBackground: !categoryButton.active

                    onClicked: root.categorySelected(categoryButton.modelData.id)
                }
            }
        }
    }

    StyledText {
        visible: root.filteredCategories.length === 0
        Layout.fillWidth: true
        Layout.topMargin: Tokens.spacing.medium
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.Wrap
        text: qsTr("No matches")
        color: Colours.palette.m3onSurfaceVariant
        font: Tokens.font.body.small
    }
}
